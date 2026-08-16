
inline_asm_x64_port_dx.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	$0x70, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	inb	%dx, %al
               	movq	-0x20(%rbp), %r10
               	movb	%al, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movzbq	-0x8(%rbp), %rax
               	andq	$0xff, %rax
               	movl	$0x70, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rdx
               	outb	%al, %dx
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	leaq	-0x8(%rbp), %rax
               	movl	$0x70, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	inw	%dx, %ax
               	movq	-0x20(%rbp), %r10
               	movw	%ax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movzwq	-0x8(%rbp), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0x70, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rdx
               	outw	%ax, %dx
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	leaq	-0x8(%rbp), %rax
               	movl	$0x70, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	inl	%dx, %eax
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movl	-0x8(%rbp), %eax
               	movl	%eax, %eax
               	movl	$0x70, %ecx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rdx
               	outl	%eax, %dx
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movl	$0x2a, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
