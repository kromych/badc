
struct_multi_byval.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x38, %rsp
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x58(%rsp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
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
               	movl	0x8(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0xc(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x10(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x14(%rsp), %ecx
               	addq	%rcx, %rax
               	addq	$0x7d0, %rax            # imm = 0x7D0
               	movl	0x18(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x1c(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x20(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x24(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x28(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x2c(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x68(%rsp), %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, <rip> # <addr>
               	addq	$0x38, %rsp
               	retq

<main>:
               	subq	$0x48, %rsp
               	subq	$0x30, %rsp
               	leaq	0x48(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	leaq	0x50(%rsp), %r8
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%r8)
               	leaq	0x58(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movl	$0x3e8, %r10d           # imm = 0x3E8
               	movq	%r10, 0x38(%rsp)
               	movl	$0x7d0, %r10d           # imm = 0x7D0
               	movq	%r10, 0x30(%rsp)
               	movabsq	$0x400000003, %rcx      # imm = 0x400000003
               	movl	$0x5, %edx
               	movabsq	$0x200000001, %rsi      # imm = 0x200000001
               	movabsq	$0x400000003, %r9       # imm = 0x400000003
               	movq	%rsi, (%rsp)
               	movq	%r9, 0x8(%rsp)
               	movq	$0xbb8, 0x28(%rsp)      # imm = 0xBB8
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	xchgq	%rcx, %rdx
               	movq	0x38(%rsp), %rsi
               	movq	0x30(%rsp), %r9
               	movq	(%rdi), %rdi
               	movl	(%r8), %r8d
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1a12, %rax           # imm = 0x1A12
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x30, %rsp
               	addq	$0x48, %rsp
               	retq
