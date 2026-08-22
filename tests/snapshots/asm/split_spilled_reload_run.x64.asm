
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
               	xorq	%rax, %rax
               	retq

<hot>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	xorq	%r13, %r13
               	movq	(%rdi), %rax
               	leaq	0x1(%rax), %rdx
               	movq	0x8(%rdi), %rax
               	leaq	0x2(%rax), %rsi
               	movq	0x10(%rdi), %rax
               	leaq	0x3(%rax), %r8
               	movq	0x18(%rdi), %rax
               	leaq	0x4(%rax), %r9
               	movq	0x20(%rdi), %rax
               	leaq	0x5(%rax), %rbx
               	movq	0x28(%rdi), %rax
               	leaq	0x6(%rax), %r12
               	movq	0x30(%rdi), %rax
               	leaq	0x7(%rax), %r14
               	movq	0x38(%rdi), %rax
               	leaq	0x8(%rax), %r15
               	movq	(%rdi), %rcx
               	movq	0x18(%rdi), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rcx, %r10
               	xorq	0x68(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x8(%rdi), %rcx
               	movq	0x28(%rdi), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%rcx, %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x10(%rdi), %rcx
               	movq	0x30(%rdi), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rcx, %r10
               	xorq	0x58(%rsp), %r10
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
               	movq	%r10, 0x30(%rsp)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	%ecx, %eax
               	leaq	(%rdx,%rax), %rdi
               	xorq	%r13, %rdi
               	leaq	(%rdx,%rdx,2), %r13
               	addq	%r13, %rdi
               	movq	%rdi, %r13
               	shrq	$0x3, %r13
               	xorq	%rdx, %r13
               	subq	%r13, %rdi
               	leaq	(%rsi,%rax), %r13
               	xorq	%r13, %rdi
               	leaq	(%rsi,%rsi,2), %r13
               	addq	%r13, %rdi
               	movq	%rdi, %r13
               	shrq	$0x3, %r13
               	xorq	%rsi, %r13
               	subq	%r13, %rdi
               	leaq	(%r8,%rax), %r13
               	xorq	%r13, %rdi
               	leaq	(%r8,%r8,2), %r13
               	addq	%r13, %rdi
               	movq	%rdi, %r13
               	shrq	$0x3, %r13
               	xorq	%r8, %r13
               	subq	%r13, %rdi
               	leaq	(%r9,%rax), %r13
               	xorq	%r13, %rdi
               	leaq	(%r9,%r9,2), %r13
               	addq	%r13, %rdi
               	movq	%rdi, %r13
               	shrq	$0x3, %r13
               	xorq	%r9, %r13
               	subq	%r13, %rdi
               	leaq	(%rbx,%rax), %r13
               	xorq	%r13, %rdi
               	leaq	(%rbx,%rbx,2), %r13
               	addq	%r13, %rdi
               	movq	%rdi, %r13
               	shrq	$0x3, %r13
               	xorq	%rbx, %r13
               	subq	%r13, %rdi
               	addq	%r12, %rax
               	xorq	%rdi, %rax
               	leaq	(%r12,%r12,2), %rdi
               	addq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x3, %rdi
               	xorq	%r12, %rdi
               	movq	%rax, %r13
               	subq	%rdi, %r13
               	movl	%ecx, %eax
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpq	$0x64, %rax
               	jb	<addr>
               	movq	%rdx, %rax
               	xorq	%rsi, %rax
               	xorq	%r8, %rax
               	xorq	%r9, %rax
               	xorq	%rbx, %rax
               	xorq	%r12, %rax
               	xorq	%r14, %rax
               	xorq	%r15, %rax
               	xorq	0x68(%rsp), %rax
               	xorq	0x60(%rsp), %rax
               	xorq	0x58(%rsp), %rax
               	xorq	0x50(%rsp), %rax
               	xorq	0x48(%rsp), %rax
               	xorq	0x40(%rsp), %rax
               	xorq	0x38(%rsp), %rax
               	xorq	0x30(%rsp), %rax
               	xorq	%r13, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq

<weird>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rsi, 0x98(%rsp)
               	xorq	%r12, %r12
               	movq	(%rdi), %rax
               	leaq	0x1(%rax), %r13
               	movq	0x8(%rdi), %rax
               	leaq	0x2(%rax), %r14
               	movq	0x10(%rdi), %rax
               	leaq	0x3(%rax), %r15
               	movq	0x18(%rdi), %rax
               	leaq	0x4(%rax), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0x20(%rdi), %rax
               	leaq	0x5(%rax), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x28(%rdi), %rax
               	leaq	0x6(%rax), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x30(%rdi), %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x38(%rdi), %rax
               	leaq	0x8(%rax), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	(%rdi), %rcx
               	movq	0x18(%rdi), %rdx
               	movq	%rcx, %r10
               	xorq	%rdx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x8(%rdi), %rcx
               	movq	0x28(%rdi), %rdx
               	movq	%rcx, %r10
               	xorq	%rdx, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x10(%rdi), %rcx
               	movq	0x30(%rdi), %rdx
               	movq	%rcx, %r10
               	xorq	%rdx, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x18(%rdi), %rcx
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x20(%rdi), %rax
               	movq	(%rdi), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x28(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x30(%rdi), %rax
               	movq	0x10(%rdi), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rdi), %rax
               	movq	0x18(%rdi), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x98(%rsp), %rbx
               	movl	%ebx, %ebx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r13, %rdi
               	xorq	0x68(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	0x98(%rsp), %rax
               	movl	%eax, %eax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%r12, %rdx
               	jmp	<addr>
               	movq	%r12, %rcx
               	jmp	<addr>
               	movl	%r12d, %eax
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
               	xorq	%rsi, %rcx
               	subq	%rcx, %rdx
               	movq	0x70(%rsp), %rcx
               	leaq	(%rcx,%rax), %rsi
               	xorq	%rsi, %rdx
               	leaq	(%rcx,%rcx,2), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	leaq	0x1(%rax), %r12
               	movl	%ebx, %eax
               	leaq	-0x1(%rax), %rbx
               	movl	%ebx, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
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
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movq	0x90(%rsp), %rcx
               	addq	%rcx, %rax
               	xorq	%rdx, %rax
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
               	xorq	0x90(%rsp), %rax
               	xorq	0x88(%rsp), %rax
               	xorq	0x80(%rsp), %rax
               	xorq	0x78(%rsp), %rax
               	xorq	0x70(%rsp), %rax
               	xorq	0x60(%rsp), %rax
               	xorq	0x58(%rsp), %rax
               	xorq	0x50(%rsp), %rax
               	xorq	0x48(%rsp), %rax
               	xorq	0x40(%rsp), %rax
               	xorq	0x38(%rsp), %rax
               	xorq	0x30(%rsp), %rax
               	xorq	0x68(%rsp), %rax
               	xorq	%rcx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
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
               	movq	%rdi, %rax
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
               	movq	%rbx, %rcx
               	xorq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
