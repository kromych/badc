
long_double_outgoing_area_borrow.x64:	file format elf64-x86-64

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

<weigh10>:
               	shlq	%rsi
               	leaq	(%rdi,%rsi), %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r9, %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	leaq	(%rcx,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rsp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	retq

<mix>:
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	leaq	(%rdi,%rdi,2), %rax
               	leaq	(%rsi,%rsi,4), %rcx
               	leaq	(%rdi,%rsi), %rdx
               	movq	%rdi, %r8
               	subq	%rsi, %r8
               	movq	%rdi, %r9
               	imulq	%rsi, %r9
               	leaq	0x7(%rdi), %rbx
               	leaq	0x9(%rsi), %r12
               	imulq	$0xb, %rdi, %r13
               	imulq	$0xd, %rsi, %r14
               	movq	%rdi, %r15
               	xorq	%rsi, %r15
               	movq	%rdi, %rbp
               	orq	$0x40, %rbp
               	movq	%rsi, %r10
               	shlq	$0x3, %r10
               	movq	%r10, 0x78(%rsp)
               	imulq	%rdi, %rdi
               	movq	%rsi, %r10
               	imulq	%rsi, %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x68(%rsp)
               	fldt	(%r10)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rcx, %r10
               	shlq	%r10
               	movq	%r10, 0x60(%rsp)
               	movq	%rax, %r10
               	addq	0x60(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	leaq	(%rdx,%rdx,2), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%r8, %r10
               	shlq	$0x2, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	leaq	(%r9,%r9,4), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	imulq	$0x6, %rbx, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	imulq	$0x7, %r12, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%r13, %r10
               	shlq	$0x3, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	leaq	(%r14,%r14,8), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	imulq	$0xa, %r15, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	imulq	$0xb, %rbp, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x78(%rsp), %r10
               	imulq	$0xc, %r10, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	imulq	$0xd, %rdi, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x70(%rsp), %r10
               	imulq	$0xe, %r10, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	vmulsd	<rip>, %xmm0, %xmm1
               	movq	0x68(%rsp), %r10
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%r10)
               	movq	%rdi, %r10
               	movq	0x70(%rsp), %rdi
               	subq	%r10, %rdi
               	addq	0x78(%rsp), %rdi
               	subq	%rbp, %rdi
               	addq	%r15, %rdi
               	subq	%r14, %rdi
               	addq	%r13, %rdi
               	movq	<rip>, %r13 # <addr>
               	movsd	%xmm0, 0x50(%rsp)
               	movq	%r12, (%rsp)
               	movq	0x60(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%rdi, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	movq	%r8, %rcx
               	movq	%r9, %r8
               	movq	%rbx, %r9
               	callq	*%r13
               	movsd	0x50(%rsp), %xmm0
               	leaq	<rip>, %rcx # <addr>
               	addq	0x60(%rsp), %rax
               	vmulsd	<rip>, %xmm0, %xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rax
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	fldt	0x20(%rcx)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	comisd	<rip>, %xmm0
               	cmovbeq	%rsi, %rdx
               	addq	%rdx, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x38, %rsp
               	retq

<main>:
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	leaq	(%rdi,%rdi,2), %rax
               	leaq	(%rsi,%rsi,4), %rcx
               	leaq	(%rdi,%rsi), %rdx
               	movq	%rdi, %r8
               	subq	%rsi, %r8
               	movq	%rdi, %r9
               	imulq	%rsi, %r9
               	leaq	0x7(%rdi), %rbx
               	leaq	0x9(%rsi), %r12
               	imulq	$0xb, %rdi, %r13
               	imulq	$0xd, %rsi, %r14
               	movq	%rdi, %r15
               	xorq	%rsi, %r15
               	movq	%rdi, %rbp
               	orq	$0x40, %rbp
               	movq	%rsi, %r10
               	shlq	$0x3, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rdi, %r10
               	imulq	%rdi, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rsi, %r10
               	imulq	%rsi, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rcx, %r10
               	shlq	%r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rax, %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	(%rdx,%rdx,2), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r8, %r10
               	shlq	$0x2, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	(%r9,%r9,4), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	imulq	$0x6, %rbx, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	imulq	$0x7, %r12, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r13, %r10
               	shlq	$0x3, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	(%r14,%r14,8), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	imulq	$0xa, %r15, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	imulq	$0xb, %rbp, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rsp), %r10
               	imulq	$0xc, %r10, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x50(%rsp), %r10
               	imulq	$0xd, %r10, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	imulq	$0xe, %r10, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	subq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rbp, %r10
               	movq	0x58(%rsp), %rbp
               	subq	%r10, %rbp
               	addq	%rbp, %r15
               	subq	%r14, %r15
               	addq	%r15, %r13
               	shlq	%rcx
               	addq	%rcx, %rax
               	leaq	(%rdx,%rdx,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %r8
               	addq	%r8, %rax
               	leaq	(%r9,%r9,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %rbx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %r12, %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	leaq	(%r13,%r13,8), %rcx
               	addq	%rcx, %rax
               	imulq	$0xa, %rsi, %rcx
               	addq	%rcx, %rax
               	addq	0x40(%rsp), %rax
               	leaq	0x7(%rax), %rbx
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	fldt	0x10(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x38, %rsp
               	retq
