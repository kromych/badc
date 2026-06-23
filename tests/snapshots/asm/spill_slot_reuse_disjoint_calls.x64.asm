
spill_slot_reuse_disjoint_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	testq	%rdi, %rdi
               	jge	<addr>
               	imulq	$-0x1, %rdi, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<twogroups>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%r13, 0x20(%rsp)
               	movq	%rdi, %rbx
               	incq	%rbx
               	movq	%rdi, %r12
               	addq	$0x2, %r12
               	movq	%rdi, %r14
               	addq	$0x3, %r14
               	movq	%rdi, %r15
               	addq	$0x4, %r15
               	movq	%rdi, %r10
               	addq	$0x5, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rdi, %r10
               	addq	$0x6, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rdi, %r10
               	addq	$0x7, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rdi, %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x30(%rsp)
               	callq	<addr>
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	addq	0x48(%rsp), %rax
               	addq	0x40(%rsp), %rax
               	addq	0x38(%rsp), %rax
               	movq	%rax, %rdi
               	addq	0x30(%rsp), %rdi
               	movq	%rdi, %rbx
               	incq	%rbx
               	movq	%rdi, %r12
               	addq	$0x2, %r12
               	movq	%rdi, %r14
               	addq	$0x3, %r14
               	movq	%rdi, %r15
               	addq	$0x4, %r15
               	movq	%rdi, %r10
               	addq	$0x5, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rdi, %r10
               	addq	$0x6, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rdi, %r10
               	addq	$0x7, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rdi, %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x30(%rsp)
               	callq	<addr>
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	addq	0x48(%rsp), %rax
               	addq	0x40(%rsp), %rax
               	addq	0x38(%rsp), %rax
               	addq	0x30(%rsp), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x574, %rax            # imm = 0x574
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x3, %rdi
               	callq	<addr>
               	cmpq	$0xba, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
