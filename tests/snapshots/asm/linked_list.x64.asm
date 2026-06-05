
linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x28(%rbp)
               	movq	%rbx, %r12
               	jmp	<addr>
               	movslq	-0x28(%rbp), %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	movq	%rdx, %r12
               	jmp	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdx
               	movslq	-0x28(%rbp), %rax
               	movq	%rax, (%rdx)
               	movq	%rdx, %rax
               	addq	$0x8, %rax
               	movq	%r12, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %r12
               	je	<addr>
               	movslq	%ebx, %rax
               	movq	(%r12), %rcx
               	movq	%rax, %rbx
               	addq	%rcx, %rbx
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
