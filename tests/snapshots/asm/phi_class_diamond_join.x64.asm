
phi_class_diamond_join.x64:	file format elf64-x86-64

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
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	cmpq	$0x0, %rdi
               	je	<addr>
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	subq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %edi
               	movl	$0xa, %esi
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x14, %edx
               	movq	%rbx, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%r12d, %r12
               	movslq	%eax, %rax
               	addq	%rax, %r12
               	movslq	%r12d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
