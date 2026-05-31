
integer_suffixes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x1, %r11d
               	movl	$0x2, %r9d
               	movl	$0x3, %r8d
               	movl	$0x4, %edi
               	movl	$0x5, %esi
               	movl	$0x6, %edx
               	movl	$0x7, %ecx
               	movl	$0x8, %eax
               	movl	$0x9, %r15d
               	movl	$0xa, %r14d
               	movl	$0xff, %r12d
               	movl	$0xcafe, %r10d          # imm = 0xCAFE
               	movq	%r10, 0x38(%rsp)
               	movabsq	$0xe8d4a51000, %r10     # imm = 0xE8D4A51000
               	movq	%r10, 0x30(%rsp)
               	movabsq	$0x100000000, %r10      # imm = 0x100000000
               	movq	%r10, 0x28(%rsp)
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x2, %r9
               	je	<addr>
               	movl	$0x2, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x3, %r8
               	je	<addr>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x4, %rdi
               	je	<addr>
               	movl	$0x4, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x5, %rsi
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x6, %rdx
               	je	<addr>
               	movl	$0x6, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0x7, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x9, %r15
               	je	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xa, %r14
               	je	<addr>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xff, %r12
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %r12
               	cmpq	$0xcafe, %r12           # imm = 0xCAFE
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movq	0x30(%rsp), %r12
               	movabsq	$0xe8d4a51000, %r11     # imm = 0xE8D4A51000
               	cmpq	%r11, %r12
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rsp), %r12
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %r12
               	je	<addr>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r12d
               	addq	$0x7, %r12
               	movslq	%r12d, %r12
               	cmpq	$0xa, %r12
               	je	<addr>
               	movl	$0xf, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
