
inline_asm_x64_seg_c_percpu.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	%gs:<rip>, %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x20(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rdx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%gs:<rip>, %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x20(%rbp), %rax
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	movl	$0x10, %edx
               	movq	%rax, -0x30(%rbp)
               	movb	%gs:0x10, %al
               	movq	-0x30(%rbp), %r10
               	movb	%al, (%r10)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x12, %edx
               	movq	%rax, -0x30(%rbp)
               	movw	%gs:0x12, %ax
               	movq	-0x30(%rbp), %r10
               	movw	%ax, (%r10)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x14, %edx
               	movq	%rax, -0x30(%rbp)
               	movl	%gs:0x14, %eax
               	movq	-0x30(%rbp), %r10
               	movl	%eax, (%r10)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x18, %edx
               	movq	%rax, -0x30(%rbp)
               	movq	%gs:0x18, %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movzbq	-0x20(%rbp), %rax
               	movzwq	-0x18(%rbp), %rdx
               	addq	%rdx, %rax
               	movl	-0x10(%rbp), %edx
               	addq	%rdx, %rax
               	movq	-0x8(%rbp), %rdx
               	addq	%rdx, %rax
               	incq	%rax
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	movl	$0x28, %edx
               	movq	%rax, -0x30(%rbp)
               	movq	%fs:0x28, %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x20(%rbp), %rax
               	addq	%rax, %rcx
               	movl	$0x20, %edx
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	%rax, %gs:0x20
               	movl	%ecx, %eax
               	movl	$0x28, %esi
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	movl	%eax, %gs:0x28
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	addq	%rax, %gs:0x20
               	movl	$0x30, %eax
               	incq	%gs:0x30
               	movl	$0x38, %eax
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	cmpq	%rax, %gs:0x38
               	movl	$0x40, %eax
               	leaq	<rip>, %rcx
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x30(%rbp), %rbx
               	nop
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	addb	%al, (%rax)
               	movq	%gs:0x40, %rax
               	movq	%gs:<rip>, %rdx
