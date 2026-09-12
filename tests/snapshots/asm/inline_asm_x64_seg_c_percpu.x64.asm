
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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	movq	%gs:<rip>, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rcx
               	movq	%gs:<rip>, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	addq	%rax, %rcx
               	movb	%gs:0x10, %al
               	movb	%al, -0x20(%rbp)
               	movw	%gs:0x12, %ax
               	movw	%ax, -0x18(%rbp)
               	movl	%gs:0x14, %eax
               	movl	%eax, -0x10(%rbp)
               	movq	%gs:0x18, %rax
               	movq	%rax, -0x8(%rbp)
               	movzbq	-0x20(%rbp), %rax
               	movzwq	-0x18(%rbp), %rdx
               	addq	%rdx, %rax
               	movl	-0x10(%rbp), %edx
               	addq	%rdx, %rax
               	movq	-0x8(%rbp), %rdx
               	addq	%rdx, %rax
               	incq	%rax
               	addq	%rax, %rcx
               	movq	%fs:0x28, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	addq	%rax, %rcx
               	movq	%rcx, %rax
               	movq	%rax, %gs:0x20
               	movl	%ecx, %eax
               	movl	%eax, %gs:0x28
               	movq	%rcx, %rax
               	addq	%rax, %gs:0x20
               	incq	%gs:0x30
               	movq	%rcx, %rax
               	cmpq	%rax, %gs:0x38
               	leaq	<rip>, %rbx
               	nop
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	addb	%ah, 0x48(%rbp)
               	movl	0x40, %eax
               	movq	%gs:<rip>, %rdx
