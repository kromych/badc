
split_spilled_reload_run.x64:	file format elf64-x86-64

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

<cold>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	retq

<hot>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rax
               	xorl	%ebx, %ebx
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	0x8(%rax), %rdx
               	addq	$0x2, %rdx
               	movq	0x10(%rax), %rsi
               	addq	$0x3, %rsi
               	movq	0x18(%rax), %rdi
               	addq	$0x4, %rdi
               	movq	0x20(%rax), %r8
               	addq	$0x5, %r8
               	movq	0x28(%rax), %r9
               	addq	$0x6, %r9
               	movq	0x30(%rax), %r12
               	leaq	0x7(%r12), %r13
               	movq	0x38(%rax), %r12
               	leaq	0x8(%r12), %r14
               	movq	(%rax), %r15
               	movq	0x18(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	xorq	0x68(%rsp), %r15
               	movq	0x8(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	xorq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x18(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	xorq	%r12, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x20(%rax), %r12
               	movq	(%rax), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%r12, %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x28(%rax), %r12
               	movq	0x8(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r12, %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x30(%rax), %r12
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r12, %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x38(%rax), %r12
               	movq	0x18(%rax), %rax
               	leaq	(%r12,%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	xorl	%eax, %eax
               	leaq	(%rcx,%rax), %r12
               	xorq	%r12, %rbx
               	leaq	(%rcx,%rcx,2), %r12
               	addq	%r12, %rbx
               	movq	%rbx, %r12
               	shrq	$0x3, %r12
               	xorq	%rcx, %r12
               	subq	%r12, %rbx
               	leaq	(%rdx,%rax), %r12
               	xorq	%r12, %rbx
               	leaq	(%rdx,%rdx,2), %r12
               	addq	%r12, %rbx
               	movq	%rbx, %r12
               	shrq	$0x3, %r12
               	xorq	%rdx, %r12
               	subq	%r12, %rbx
               	leaq	(%rsi,%rax), %r12
               	xorq	%r12, %rbx
               	leaq	(%rsi,%rsi,2), %r12
               	addq	%r12, %rbx
               	movq	%rbx, %r12
               	shrq	$0x3, %r12
               	xorq	%rsi, %r12
               	subq	%r12, %rbx
               	leaq	(%rdi,%rax), %r12
               	xorq	%r12, %rbx
               	leaq	(%rdi,%rdi,2), %r12
               	addq	%r12, %rbx
               	movq	%rbx, %r12
               	shrq	$0x3, %r12
               	xorq	%rdi, %r12
               	subq	%r12, %rbx
               	leaq	(%r8,%rax), %r12
               	xorq	%r12, %rbx
               	leaq	(%r8,%r8,2), %r12
               	addq	%r12, %rbx
               	movq	%rbx, %r12
               	shrq	$0x3, %r12
               	xorq	%r8, %r12
               	subq	%r12, %rbx
               	leaq	(%r9,%rax), %r12
               	xorq	%r12, %rbx
               	leaq	(%r9,%r9,2), %r12
               	addq	%r12, %rbx
               	movq	%rbx, %r12
               	shrq	$0x3, %r12
               	xorq	%r9, %r12
               	subq	%r12, %rbx
               	incq	%rax
               	cmpl	$0x64, %eax
               	jb	<addr>
               	movq	%rcx, %rax
               	xorq	%rdx, %rax
               	xorq	%rsi, %rax
               	xorq	%rdi, %rax
               	xorq	%r8, %rax
               	xorq	%r9, %rax
               	xorq	%r13, %rax
               	xorq	%r14, %rax
               	xorq	%r15, %rax
               	xorq	0x68(%rsp), %rax
               	xorq	0x60(%rsp), %rax
               	xorq	0x58(%rsp), %rax
               	xorq	0x50(%rsp), %rax
               	xorq	0x48(%rsp), %rax
               	xorq	0x40(%rsp), %rax
               	xorq	0x38(%rsp), %rax
               	xorq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<weird>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %rbx
               	xorl	%r12d, %r12d
               	movq	(%rdi), %rax
               	leaq	0x1(%rax), %r13
               	movq	0x8(%rdi), %rax
               	leaq	0x2(%rax), %r14
               	movq	0x10(%rdi), %rax
               	leaq	0x3(%rax), %r15
               	movq	0x18(%rdi), %rax
               	leaq	0x4(%rax), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0x20(%rdi), %rax
               	leaq	0x5(%rax), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0x28(%rdi), %rax
               	leaq	0x6(%rax), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x30(%rdi), %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x38(%rdi), %rax
               	leaq	0x8(%rax), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	(%rdi), %rcx
               	movq	0x18(%rdi), %rdx
               	movq	%rcx, %r10
               	xorq	%rdx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x8(%rdi), %rcx
               	movq	0x28(%rdi), %rdx
               	movq	%rcx, %r10
               	xorq	%rdx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x10(%rdi), %rcx
               	movq	0x30(%rdi), %rdx
               	movq	%rcx, %r10
               	xorq	%rdx, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x18(%rdi), %rcx
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x20(%rdi), %rax
               	movq	(%rdi), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x28(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x30(%rdi), %rax
               	movq	0x10(%rdi), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rdi), %rax
               	movq	0x18(%rdi), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x70(%rsp)
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	xorq	0x70(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	testb	$0x1, %bl
               	je	<addr>
               	movq	%r12, %rdx
               	jmp	<addr>
               	movq	%r12, %rcx
               	jmp	<addr>
               	movl	%r12d, %eax
               	movq	0x90(%rsp), %rcx
               	leaq	(%rcx,%rax), %rsi
               	xorq	%rsi, %rdx
               	leaq	(%rcx,%rcx,2), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3, %rsi
               	xorq	%rsi, %rcx
               	subq	%rcx, %rdx
               	movq	0x88(%rsp), %rcx
               	leaq	(%rcx,%rax), %rsi
               	xorq	%rsi, %rdx
               	leaq	(%rcx,%rcx,2), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3, %rsi
               	xorq	%rsi, %rcx
               	subq	%rcx, %rdx
               	movq	0x80(%rsp), %rcx
               	leaq	(%rcx,%rax), %rsi
               	xorq	%rsi, %rdx
               	leaq	(%rcx,%rcx,2), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3, %rsi
               	xorq	%rsi, %rcx
               	subq	%rcx, %rdx
               	movq	0x78(%rsp), %rcx
               	leaq	(%rcx,%rax), %rsi
               	xorq	%rsi, %rdx
               	leaq	(%rcx,%rcx,2), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3, %rsi
               	xorq	%rcx, %rsi
               	movq	%rdx, %rcx
               	subq	%rsi, %rcx
               	leaq	0x1(%rax), %r12
               	decq	%rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	movl	%r12d, %eax
               	leaq	(%r13,%rax), %rdx
               	xorq	%rdx, %rcx
               	leaq	(%r13,%r13,2), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3, %rdx
               	xorq	%r13, %rdx
               	subq	%rdx, %rcx
               	leaq	(%r14,%rax), %rdx
               	xorq	%rdx, %rcx
               	leaq	(%r14,%r14,2), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3, %rdx
               	xorq	%r14, %rdx
               	subq	%rdx, %rcx
               	leaq	(%r15,%rax), %rdx
               	xorq	%rdx, %rcx
               	leaq	(%r15,%r15,2), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3, %rdx
               	xorq	%r15, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movq	0x98(%rsp), %rcx
               	addq	%rcx, %rax
               	xorq	%rsi, %rax
               	leaq	(%rcx,%rcx,2), %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x3, %rdx
               	xorq	%rdx, %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	jmp	<addr>
               	movq	%r13, %rax
               	xorq	%r14, %rax
               	xorq	%r15, %rax
               	xorq	0x98(%rsp), %rax
               	xorq	0x90(%rsp), %rax
               	xorq	0x88(%rsp), %rax
               	xorq	0x80(%rsp), %rax
               	xorq	0x78(%rsp), %rax
               	xorq	0x68(%rsp), %rax
               	xorq	0x60(%rsp), %rax
               	xorq	0x58(%rsp), %rax
               	xorq	0x50(%rsp), %rax
               	xorq	0x48(%rsp), %rax
               	xorq	0x40(%rsp), %rax
               	xorq	0x38(%rsp), %rax
               	xorq	0x70(%rsp), %rax
               	xorq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdi)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rdi)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%rdi)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%rdi)
               	popq	%rcx
               	movl	$0x64, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x29, %esi
               	callq	<addr>
               	xorq	%rax, %rbx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x28, %esi
               	callq	<addr>
               	xorq	%rbx, %rax
               	leaq	<rip>, %rcx
               	cmpq	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	andq	$0xff, %rax
               	popq	%rbx
               	leave
               	retq
