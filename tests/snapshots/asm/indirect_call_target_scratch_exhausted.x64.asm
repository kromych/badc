
indirect_call_target_scratch_exhausted.x64:	file format elf64-x86-64

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

<sum16p>:
               	subq	$0xd8, %rsp
               	movq	0xe0(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0xe8(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0xf0(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0xf8(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x100(%rsp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x108(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x110(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x118(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x120(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x128(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x130(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x138(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x140(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x148(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x150(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x158(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x160(%rsp), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x168(%rsp), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x170(%rsp), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0x178(%rsp), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0x180(%rsp), %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0x188(%rsp), %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0x190(%rsp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	0x198(%rsp), %r10
               	movq	%r10, 0xb8(%rsp)
               	movq	0x1a0(%rsp), %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	0x1a8(%rsp), %r10
               	movq	%r10, 0xc8(%rsp)
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x30(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x60(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x80(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x88(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x90(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x98(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xa0(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xa8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xb0(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xb8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xc0(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xc8(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0xd8, %rsp
               	retq

<main>:
               	subq	$0x70, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xd0, %rsp
               	movq	$0x0, <rip> # <addr>
               	movq	$0x0, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x6, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x8, <rip> # <addr>
               	movq	$0x5, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x6, <rip> # <addr>
               	movq	$0xc, <rip> # <addr>
               	movq	$0x7, <rip> # <addr>
               	movq	$0xe, <rip> # <addr>
               	movq	$0x8, <rip> # <addr>
               	movq	$0x10, <rip> # <addr>
               	movq	$0x9, <rip> # <addr>
               	movq	$0x12, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x14, <rip> # <addr>
               	movq	$0xb, <rip> # <addr>
               	movq	$0x16, <rip> # <addr>
               	movq	$0xc, <rip> # <addr>
               	movq	$0x18, <rip> # <addr>
               	movq	$0xd, <rip> # <addr>
               	movq	$0x1a, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	$0xe, <rip> # <addr>
               	movq	$0x1c, <rip> # <addr>
               	movq	$0xf, <rip> # <addr>
               	movq	$0x1e, <rip> # <addr>
               	leaq	0x50(%rax), %r10
               	movq	%r10, 0x148(%rsp)
               	leaq	0x60(%rax), %r10
               	movq	%r10, 0x140(%rsp)
               	leaq	0x70(%rax), %r10
               	movq	%r10, 0x138(%rsp)
               	leaq	0x80(%rax), %r10
               	movq	%r10, 0x130(%rsp)
               	leaq	0x90(%rax), %r10
               	movq	%r10, 0x128(%rsp)
               	leaq	0xa0(%rax), %r10
               	movq	%r10, 0x120(%rsp)
               	leaq	0xb0(%rax), %r10
               	movq	%r10, 0x118(%rsp)
               	leaq	0xc0(%rax), %r10
               	movq	%r10, 0x110(%rsp)
               	leaq	0xd0(%rax), %r10
               	movq	%r10, 0x108(%rsp)
               	leaq	0xe0(%rax), %r10
               	movq	%r10, 0x100(%rsp)
               	leaq	0xf0(%rax), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	movq	<rip>, %r9 # <addr>
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	%r9, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	0x148(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x140(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x138(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x130(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	0x128(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x60(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x68(%rsp)
               	movq	0x120(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	0x118(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x80(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x88(%rsp)
               	movq	0x110(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x90(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x98(%rsp)
               	movq	0x108(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xa0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xa8(%rsp)
               	movq	0x100(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xb0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xb8(%rsp)
               	movq	0xf8(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xc0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xc8(%rsp)
               	movq	%r8, %r9
               	movq	%rdi, %r8
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	cmpq	$0x168, %rax            # imm = 0x168
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xd0, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x70, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xd0, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x70, %rsp
               	retq
