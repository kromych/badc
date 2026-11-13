
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
               	movq	<rip>, %rax # <addr>
               	addq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
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
               	movq	(%rax), %r12
               	leaq	0x1(%r12), %rcx
               	movq	0x8(%rax), %rdx
               	addq	$0x2, %rdx
               	movq	0x10(%rax), %rsi
               	addq	$0x3, %rsi
               	movq	0x18(%rax), %r13
               	leaq	0x4(%r13), %r8
               	movq	0x20(%rax), %rdi
               	leaq	0x5(%rdi), %r9
               	movq	0x28(%rax), %r14
               	leaq	0x6(%r14), %rdi
               	movq	0x30(%rax), %r15
               	leaq	0x7(%r15), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r12, %r10
               	xorq	%r13, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x8(%rax), %r12
               	movq	%r12, %r10
               	xorq	%r14, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x10(%rax), %r13
               	xorq	%r13, %r15
               	movq	0x18(%rax), %r14
               	movq	%r14, %r10
               	xorq	0x68(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	addq	%r12, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x30(%rax), %r12
               	addq	%r12, %r13
               	movq	0x38(%rax), %rax
               	addq	%rax, %r14
               	xorl	%eax, %eax
               	leaq	(%rcx,%rax), %r12
               	xorq	%rbx, %r12
               	leaq	(%rcx,%rcx,2), %rbx
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
               	leaq	(%rdi,%rax), %r12
               	xorq	%r12, %rbx
               	leaq	(%rdi,%rdi,2), %r12
               	addq	%r12, %rbx
               	movq	%rbx, %r12
               	shrq	$0x3, %r12
               	xorq	%rdi, %r12
               	subq	%r12, %rbx
               	incq	%rax
               	cmpl	$0x64, %eax
               	jb	<addr>
               	xorq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	xorq	%r8, %rcx
               	xorq	%r9, %rcx
               	xorq	%rdi, %rcx
               	xorq	0x60(%rsp), %rcx
               	xorq	0x58(%rsp), %rcx
               	xorq	0x50(%rsp), %rcx
               	xorq	0x48(%rsp), %rcx
               	xorq	%r15, %rcx
               	xorq	0x68(%rsp), %rcx
               	xorq	0x40(%rsp), %rcx
               	xorq	0x38(%rsp), %rcx
               	xorq	%r13, %rcx
               	movq	%rcx, %rax
               	xorq	%r14, %rax
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
               	movq	%rdi, %rax
               	movq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdx
               	movq	0x8(%rax), %rdi
               	leaq	0x2(%rdi), %r8
               	movq	0x10(%rax), %rdi
               	leaq	0x3(%rdi), %r9
               	movq	0x18(%rax), %r15
               	leaq	0x4(%r15), %rdi
               	movq	0x20(%rax), %rbx
               	addq	$0x5, %rbx
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0x98(%rsp), %r12
               	addq	$0x6, %r12
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0x90(%rsp), %r13
               	addq	$0x7, %r13
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x88(%rsp), %r14
               	addq	$0x8, %r14
               	movq	%rcx, %r10
               	xorq	%r15, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, %r10
               	xorq	0x98(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x10(%rax), %r15
               	movq	%r15, %r10
               	xorq	0x90(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x18(%rax), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0x98(%rsp), %r10
               	xorq	0x88(%rsp), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x90(%rsp), %r10
               	addq	0x68(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0x90(%rsp), %r10
               	addq	%rcx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x30(%rax), %rcx
               	leaq	(%rcx,%r15), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x38(%rax), %rax
               	movq	%rax, %r10
               	addq	0x98(%rsp), %r10
               	movq	%r10, 0x90(%rsp)
               	testl	%esi, %esi
               	jne	<addr>
               	movq	%rdx, %rax
               	xorq	0x90(%rsp), %rax
               	movq	<rip>, %rcx # <addr>
               	movq	%rsi, 0x30(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%r8, 0x48(%rsp)
               	movq	%r9, 0x40(%rsp)
               	movq	%rdi, 0x38(%rsp)
               	movq	%rax, %rdi
               	callq	*%rcx
               	movq	0x30(%rsp), %rsi
               	movq	0x50(%rsp), %rdx
               	movq	0x48(%rsp), %r8
               	movq	0x40(%rsp), %r9
               	movq	0x38(%rsp), %rdi
               	testb	$0x1, %sil
               	je	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	%eax, %eax
               	leaq	(%rbx,%rax), %r15
               	xorq	%r15, %rcx
               	leaq	(%rbx,%rbx,2), %r15
               	addq	%r15, %rcx
               	movq	%rcx, %r15
               	shrq	$0x3, %r15
               	xorq	%rbx, %r15
               	subq	%r15, %rcx
               	leaq	(%r12,%rax), %r15
               	xorq	%r15, %rcx
               	leaq	(%r12,%r12,2), %r15
               	addq	%r15, %rcx
               	movq	%rcx, %r15
               	shrq	$0x3, %r15
               	xorq	%r12, %r15
               	subq	%r15, %rcx
               	leaq	(%r13,%rax), %r15
               	xorq	%r15, %rcx
               	leaq	(%r13,%r13,2), %r15
               	addq	%r15, %rcx
               	movq	%rcx, %r15
               	shrq	$0x3, %r15
               	xorq	%r13, %r15
               	subq	%r15, %rcx
               	leaq	(%r14,%rax), %r15
               	xorq	%r15, %rcx
               	leaq	(%r14,%r14,2), %r15
               	addq	%rcx, %r15
               	movq	%r15, %rcx
               	shrq	$0x3, %rcx
               	xorq	%r14, %rcx
               	subq	%rcx, %r15
               	incq	%rax
               	subl	$0x1, %esi
               	jne	<addr>
               	movq	%rdx, %rax
               	xorq	%r8, %rax
               	xorq	%r9, %rax
               	xorq	%rdi, %rax
               	xorq	%rbx, %rax
               	xorq	%r12, %rax
               	xorq	%r13, %rax
               	xorq	%r14, %rax
               	xorq	0x80(%rsp), %rax
               	xorq	0x78(%rsp), %rax
               	xorq	0x70(%rsp), %rax
               	xorq	0x88(%rsp), %rax
               	xorq	0x68(%rsp), %rax
               	xorq	0x60(%rsp), %rax
               	xorq	0x58(%rsp), %rax
               	xorq	0x90(%rsp), %rax
               	xorq	%r15, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	%eax, %ecx
               	leaq	(%rdx,%rcx), %r10
               	movq	%r10, 0x98(%rsp)
               	xorq	0x98(%rsp), %r15
               	leaq	(%rdx,%rdx,2), %r10
               	movq	%r10, 0x98(%rsp)
               	addq	0x98(%rsp), %r15
               	movq	%r15, %r10
               	shrq	$0x3, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	%rdx, %r10
               	xorq	0x98(%rsp), %r10
               	movq	%r10, 0x98(%rsp)
               	subq	0x98(%rsp), %r15
               	leaq	(%r8,%rcx), %r10
               	movq	%r10, 0x98(%rsp)
               	xorq	0x98(%rsp), %r15
               	leaq	(%r8,%r8,2), %r10
               	movq	%r10, 0x98(%rsp)
               	addq	0x98(%rsp), %r15
               	movq	%r15, %r10
               	shrq	$0x3, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	%r8, %r10
               	xorq	0x98(%rsp), %r10
               	movq	%r10, 0x98(%rsp)
               	subq	0x98(%rsp), %r15
               	leaq	(%r9,%rcx), %r10
               	movq	%r10, 0x98(%rsp)
               	xorq	0x98(%rsp), %r15
               	leaq	(%r9,%r9,2), %r10
               	movq	%r10, 0x98(%rsp)
               	addq	0x98(%rsp), %r15
               	movq	%r15, %r10
               	shrq	$0x3, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	%r9, %r10
               	xorq	0x98(%rsp), %r10
               	movq	%r10, 0x98(%rsp)
               	subq	0x98(%rsp), %r15
               	addq	%rdi, %rcx
               	xorq	%r15, %rcx
               	leaq	(%rdi,%rdi,2), %r15
               	addq	%r15, %rcx
               	movq	%rcx, %r15
               	shrq	$0x3, %r15
               	xorq	%rdi, %r15
               	subq	%r15, %rcx
               	jmp	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %r15
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	movups	0x30(%rax), %xmm14
               	movups	%xmm14, 0x30(%rdi)
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
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	andq	$0xff, %rax
               	popq	%rbx
               	leave
               	retq
