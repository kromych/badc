
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
               	subq	$0x50, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rbx, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	-0x38(%rbp), %rbx
               	movq	%gs:<rip>, %rax
               	movq	-0x40(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%gs:<rip>, %rax
               	movq	-0x48(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x20(%rbp), %rax
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x10, %edx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movb	%gs:0x10, %al
               	movq	-0x48(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x50(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x12, %edx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movw	%gs:0x12, %ax
               	movq	-0x48(%rbp), %r10
               	movw	%ax, (%r10)
               	movq	-0x50(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x14, %edx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movl	%gs:0x14, %eax
               	movq	-0x48(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x50(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x18, %edx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%gs:0x18, %rax
               	movq	-0x48(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movzbq	-0x20(%rbp), %rcx
               	movzwq	-0x18(%rbp), %rdx
               	addq	%rdx, %rcx
               	movl	-0x10(%rbp), %edx
               	addq	%rdx, %rcx
               	movq	-0x8(%rbp), %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x28, %edx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rdx, -0x40(%rbp)
               	movq	%fs:0x28, %rax
               	movq	-0x48(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movl	$0x20, %ecx
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	-0x48(%rbp), %rax
               	movq	%rax, %gs:0x20
               	movq	-0x50(%rbp), %rax
               	movl	%eax, %edx
               	movl	$0x28, %esi
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	movq	-0x48(%rbp), %rax
               	movl	%eax, %gs:0x28
               	movq	-0x50(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	-0x48(%rbp), %rax
               	addq	%rax, %gs:0x20
               	movq	-0x50(%rbp), %rax
               	movl	$0x30, %ecx
               	movq	%rcx, -0x50(%rbp)
               	incq	%gs:0x30
               	movl	$0x38, %ecx
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	-0x48(%rbp), %rax
               	cmpq	%rax, %gs:0x38
               	movq	-0x50(%rbp), %rax
               	movl	$0x40, %eax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x30(%rbp), %rbx
               	nop
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rdx
               	movq	-0x40(%rbp), %rbx
               	movl	$0x2a, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%ah, 0x48(%rbp)
               	movl	0x40, %eax
               	movq	%gs:<rip>, %rdx
