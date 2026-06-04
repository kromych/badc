
switch_statement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2, %eax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	$0x14, %edx
               	jmp	<addr>
               	movslq	%edx, %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x64, %eax
               	jmp	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
