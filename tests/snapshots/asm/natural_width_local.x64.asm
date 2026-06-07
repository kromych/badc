
natural_width_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x12c, %eax            # imm = 0x12C
               	movl	$0xc8, %ecx
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movslq	%edx, %rdi
               	cmpq	$0x4, %rdi
               	jge	<addr>
               	movslq	%esi, %rsi
               	movsbq	%al, %rdi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	movsbq	%al, %rdx
               	cmpq	$0x2c, %rdx
               	je	<addr>
               	movq	%rdi, %rdx
               	incq	%rdx
               	movslq	%edx, %rdi
               	jmp	<addr>
               	andq	$0xff, %rax
               	xorq	$0x2c, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%edi, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rdi
               	jmp	<addr>
               	movsbq	%cl, %rax
               	cmpq	$-0x38, %rax
               	je	<addr>
               	movslq	%edi, %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rdi
               	jmp	<addr>
               	movslq	%esi, %rax
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movslq	%edi, %rax
               	addq	$0x8, %rax
               	movslq	%eax, %rdi
               	jmp	<addr>
               	movslq	%edi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
