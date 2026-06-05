
switch_break_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movl	$0x64, %eax
               	retq
               	movl	$0xc8, %eax
               	retq
               	movl	$0x12c, %eax            # imm = 0x12C
               	retq
               	movl	$0x190, %eax            # imm = 0x190
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	cmpq	$0x1, %rbx
               	je	<addr>
               	cmpq	$0x2, %rbx
               	je	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
