
struct_multi_byval.x64:	file format elf64-x86-64

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

<take_many>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movq	%rdx, %rsi
               	shrq	$0x20, %rsi
               	addq	%rdi, %rax
               	addq	$0x3e8, %rax            # imm = 0x3E8
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	movl	-0x28(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x24(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x20(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x1c(%rbp), %ecx
               	addq	%rcx, %rax
               	addq	$0x7d0, %rax            # imm = 0x7D0
               	movl	-0x18(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x14(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x10(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xc(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x8(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x4(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	0x38(%rbp), %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, <rip> # <addr>
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	movl	$0x7d0, %r9d            # imm = 0x7D0
               	leaq	-0x48(%rbp), %rdi
               	movabsq	$0x140000000a, %rax     # imm = 0x140000000A
               	movq	%rax, -0x48(%rbp)
               	leaq	-0x38(%rbp), %rdx
               	movabsq	$0x400000003, %rax      # imm = 0x400000003
               	movq	%rax, -0x38(%rbp)
               	movl	$0x5, -0x30(%rbp)
               	leaq	-0x40(%rbp), %r8
               	movl	$0x7, -0x40(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movabsq	$0x200000001, %rcx      # imm = 0x200000001
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0x400000003, %rcx      # imm = 0x400000003
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movabsq	$0x6500000064, %rbx     # imm = 0x6500000064
               	movq	%rbx, -0x18(%rbp)
               	movabsq	$0x6700000066, %rbx     # imm = 0x6700000066
               	movq	%rbx, -0x10(%rbp)
               	movabsq	$0x6900000068, %rbx     # imm = 0x6900000068
               	movq	%rbx, -0x8(%rbp)
               	subq	$0x30, %rsp
               	movq	$0xbb8, 0x28(%rsp)      # imm = 0xBB8
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	(%rdi), %rdi
               	movl	0x8(%rdx), %ecx
               	movq	(%rdx), %rdx
               	movl	(%r8), %r8d
               	callq	<addr>
               	addq	$0x30, %rsp
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1a12, %rax           # imm = 0x1A12
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
