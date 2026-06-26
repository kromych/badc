
integer_suffixes.x64:	file format elf64-x86-64

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
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0x1, %eax
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %ebx
               	movl	$0x8, %r12d
               	movl	$0x9, %r13d
               	movl	$0xa, %r14d
               	movl	$0xff, %r15d
               	movl	$0xcafe, %r10d          # imm = 0xCAFE
               	movq	%r10, 0x48(%rsp)
               	movabsq	$0xe8d4a51000, %r10     # imm = 0xE8D4A51000
               	movq	%r10, 0x40(%rsp)
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x2, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x3, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x4, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x5, %r8
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x6, %r9
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x7, %rbx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x8, %r12
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x9, %r13
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xa, %r14
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xff, %r15
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movq	0x48(%rsp), %rax
               	cmpq	$0xcafe, %rax           # imm = 0xCAFE
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movq	0x40(%rsp), %rax
               	movabsq	$0xe8d4a51000, %r11     # imm = 0xE8D4A51000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
