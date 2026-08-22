
local_array_runtime_init.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0xa(%rax)
               	leaq	<rip>, %rcx
               	movl	$0x5678, %edx           # imm = 0x5678
               	movw	%dx, 0xa(%rcx)
               	leaq	-0x8(%rbp), %rdx
               	xorq	%rsi, %rsi
               	movl	%esi, (%rdx)
               	movzwq	0xa(%rax), %rax
               	leaq	-0x8(%rbp), %rdx
               	movw	%ax, (%rdx)
               	movzwq	0xa(%rcx), %rcx
               	leaq	-0x8(%rbp), %rax
               	movw	%cx, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	leaq	-0x8(%rbp), %rcx
               	movzwq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x477198, %rax         # imm = 0x477198
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x63, %eax
               	leaq	-0x8(%rbp), %rdx
               	movb	%al, (%rdx)
               	movl	$0x62, %edx
               	leaq	-0x8(%rbp), %rax
               	movb	%dl, 0x1(%rax)
               	movl	$0x3, %edx
               	leaq	-0x8(%rbp), %rax
               	movb	%dl, 0x2(%rax)
               	movl	$0x64, %edx
               	leaq	-0x8(%rbp), %rax
               	movb	%dl, 0x3(%rax)
               	leaq	-0x8(%rbp), %rax
               	addq	$0x0, %rax
               	movsbq	(%rax), %rax
               	addq	$0x0, %rax
               	leaq	-0x8(%rbp), %rcx
               	movsbq	0x1(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x8(%rbp), %rcx
               	movsbq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x8(%rbp), %rcx
               	movsbq	0x3(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
