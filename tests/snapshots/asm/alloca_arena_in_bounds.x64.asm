
alloca_arena_in_bounds.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2040, %rsp           # imm = 0x2040
               	movq	%r13, (%rsp)
               	leaq	-0x28(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x1f40, %edx           # imm = 0x1F40
               	movq	%rdx, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x28(%rbp), %r13
               	movq	(%r13), %rax
               	subq	%r10, %rax
               	leaq	-0x2000(%r13), %r10
               	cmpq	%r10, %rax
               	jae	<addr>
               	ud2
               	movq	%rax, (%r13)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdi
               	movl	$0x3, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x1f40, %rax           # imm = 0x1F40
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	movslq	-0x18(%rbp), %rdx
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x5dc0, %rax           # imm = 0x5DC0
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x2030(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x2030(%rbp)
               	movq	-0x2030(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x2040, %rsp           # imm = 0x2040
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
