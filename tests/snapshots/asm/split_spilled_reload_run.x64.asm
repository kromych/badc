
split_spilled_reload_run.x64:	file format elf64-x86-64

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

<cold>:
               	movq	<rip>, %rax # <addr>
               	addq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	retq

<hot>:
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %rcx
               	xorl	%eax, %eax
               	movq	(%rcx), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%r10, %rdx
               	incq	%rdx
               	movq	0x8(%rcx), %rsi
               	leaq	0x2(%rsi), %r9
               	movq	0x10(%rcx), %rsi
               	leaq	0x3(%rsi), %rdi
               	movq	0x18(%rcx), %r12
               	leaq	0x4(%r12), %rbx
               	movq	0x20(%rcx), %rsi
               	addq	$0x5, %rsi
               	movq	0x28(%rcx), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	%r10, %r8
               	addq	$0x6, %r8
               	movq	0x30(%rcx), %r10
               	movq	%r10, 0x68(%rsp)
               	addq	$0x7, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x38(%rcx), %r10
               	movq	%r10, 0x60(%rsp)
               	addq	$0x8, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x78(%rsp), %r10
               	xorq	%r12, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x8(%rcx), %r12
               	movq	%r12, %r10
               	xorq	0x70(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x10(%rcx), %r13
               	movq	%r13, %r10
               	xorq	0x68(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x18(%rcx), %r14
               	movq	%r14, %r10
               	xorq	0x60(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x20(%rcx), %r15
               	movq	(%rcx), %rbp
               	leaq	(%r15,%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x28(%rcx), %r15
               	leaq	(%r15,%r12), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x30(%rcx), %r12
               	leaq	(%r12,%r13), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rcx), %rcx
               	leaq	(%rcx,%r14), %r10
               	movq	%r10, 0x30(%rsp)
               	xorl	%ecx, %ecx
               	leaq	(%rdx,%rdx,2), %r13
               	leaq	(%r9,%r9,2), %r14
               	leaq	(%rdi,%rdi,2), %r15
               	leaq	(%rbx,%rbx,2), %rbp
               	leaq	(%rdx,%rcx), %r12
               	xorq	%rax, %r12
               	leaq	(%r12,%r13), %rax
               	movq	%rax, %r12
               	shrq	$0x3, %r12
               	xorq	%rdx, %r12
               	subq	%r12, %rax
               	leaq	(%r9,%rcx), %r12
               	xorq	%r12, %rax
               	addq	%r14, %rax
               	movq	%rax, %r12
               	shrq	$0x3, %r12
               	xorq	%r9, %r12
               	subq	%r12, %rax
               	leaq	(%rdi,%rcx), %r12
               	xorq	%r12, %rax
               	addq	%r15, %rax
               	movq	%rax, %r12
               	shrq	$0x3, %r12
               	xorq	%rdi, %r12
               	subq	%r12, %rax
               	leaq	(%rbx,%rcx), %r12
               	xorq	%r12, %rax
               	addq	%rbp, %rax
               	movq	%rax, %r12
               	shrq	$0x3, %r12
               	xorq	%rbx, %r12
               	subq	%r12, %rax
               	leaq	(%rsi,%rcx), %r12
               	xorq	%r12, %rax
               	leaq	(%rsi,%rsi,2), %r12
               	addq	%r12, %rax
               	movq	%rax, %r12
               	shrq	$0x3, %r12
               	xorq	%rsi, %r12
               	subq	%r12, %rax
               	leaq	(%r8,%rcx), %r12
               	xorq	%r12, %rax
               	leaq	(%r8,%r8,2), %r12
               	addq	%r12, %rax
               	movq	%rax, %r12
               	shrq	$0x3, %r12
               	xorq	%r8, %r12
               	subq	%r12, %rax
               	incq	%rcx
               	cmpl	$0x64, %ecx
               	jb	<addr>
               	xorq	%r9, %rdx
               	xorq	%rdi, %rdx
               	xorq	%rbx, %rdx
               	xorq	%rsi, %rdx
               	xorq	%r8, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	0x50(%rsp), %rdx
               	xorq	0x78(%rsp), %rdx
               	xorq	0x70(%rsp), %rdx
               	xorq	0x68(%rsp), %rdx
               	xorq	0x60(%rsp), %rdx
               	xorq	0x48(%rsp), %rdx
               	xorq	0x40(%rsp), %rdx
               	xorq	0x38(%rsp), %rdx
               	xorq	0x30(%rsp), %rdx
               	xorq	%rdx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x58, %rsp
               	retq

<weird>:
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %rax
               	movq	(%rax), %rcx
               	leaq	0x1(%rcx), %r12
               	movq	0x8(%rax), %rdx
               	leaq	0x2(%rdx), %r13
               	movq	0x10(%rax), %rdx
               	leaq	0x3(%rdx), %r14
               	movq	0x18(%rax), %rbx
               	leaq	0x4(%rbx), %r15
               	movq	0x20(%rax), %rdx
               	addq	$0x5, %rdx
               	movq	0x28(%rax), %rbp
               	leaq	0x6(%rbp), %r8
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	%r10, %r9
               	addq	$0x7, %r9
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	%r10, %rdi
               	addq	$0x8, %rdi
               	movq	%rcx, %r10
               	xorq	%rbx, %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, %r10
               	xorq	%rbp, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x10(%rax), %rbx
               	movq	%rbx, %r10
               	xorq	0x98(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x18(%rax), %rbp
               	movq	%rbp, %r10
               	xorq	0x90(%rsp), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	(%rax), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x98(%rsp), %r10
               	addq	0x70(%rsp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x98(%rsp)
               	addq	%rcx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x30(%rax), %rcx
               	leaq	(%rcx,%rbx), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x38(%rax), %rax
               	leaq	(%rax,%rbp), %r10
               	movq	%r10, 0x98(%rsp)
               	testl	%esi, %esi
               	jne	<addr>
               	movq	%r12, %rax
               	xorq	0x98(%rsp), %rax
               	movq	<rip>, %rcx # <addr>
               	movq	%rsi, 0x38(%rsp)
               	movq	%rdx, 0x58(%rsp)
               	movq	%r8, 0x50(%rsp)
               	movq	%r9, 0x48(%rsp)
               	movq	%rdi, 0x40(%rsp)
               	movq	%rax, %rdi
               	callq	*%rcx
               	movq	0x38(%rsp), %rsi
               	movq	0x58(%rsp), %rdx
               	movq	0x50(%rsp), %r8
               	movq	0x48(%rsp), %r9
               	movq	0x40(%rsp), %rdi
               	testb	$0x1, %sil
               	je	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	%eax, %eax
               	leaq	(%rdx,%rax), %rbx
               	xorq	%rbx, %rcx
               	leaq	(%rdx,%rdx,2), %rbx
               	addq	%rbx, %rcx
               	movq	%rcx, %rbx
               	shrq	$0x3, %rbx
               	xorq	%rdx, %rbx
               	subq	%rbx, %rcx
               	leaq	(%r8,%rax), %rbx
               	xorq	%rbx, %rcx
               	leaq	(%r8,%r8,2), %rbx
               	addq	%rbx, %rcx
               	movq	%rcx, %rbx
               	shrq	$0x3, %rbx
               	xorq	%r8, %rbx
               	subq	%rbx, %rcx
               	leaq	(%r9,%rax), %rbx
               	xorq	%rbx, %rcx
               	leaq	(%r9,%r9,2), %rbx
               	addq	%rbx, %rcx
               	movq	%rcx, %rbx
               	shrq	$0x3, %rbx
               	xorq	%r9, %rbx
               	subq	%rbx, %rcx
               	leaq	(%rdi,%rax), %rbx
               	xorq	%rbx, %rcx
               	leaq	(%rdi,%rdi,2), %rbx
               	addq	%rbx, %rcx
               	movq	%rcx, %rbx
               	shrq	$0x3, %rbx
               	xorq	%rdi, %rbx
               	subq	%rbx, %rcx
               	incq	%rax
               	subl	$0x1, %esi
               	jne	<addr>
               	movq	%r12, %rax
               	xorq	%r13, %rax
               	xorq	%r14, %rax
               	xorq	%r15, %rax
               	xorq	%rdx, %rax
               	xorq	%r8, %rax
               	xorq	%r9, %rax
               	xorq	%rdi, %rax
               	xorq	0x88(%rsp), %rax
               	xorq	0x80(%rsp), %rax
               	xorq	0x78(%rsp), %rax
               	xorq	0x90(%rsp), %rax
               	xorq	0x70(%rsp), %rax
               	xorq	0x68(%rsp), %rax
               	xorq	0x60(%rsp), %rax
               	xorq	0x98(%rsp), %rax
               	xorq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x78, %rsp
               	retq
               	movl	%eax, %ebx
               	leaq	(%r12,%rbx), %rbp
               	xorq	%rbp, %rcx
               	leaq	(%r12,%r12,2), %rbp
               	addq	%rbp, %rcx
               	movq	%rcx, %rbp
               	shrq	$0x3, %rbp
               	xorq	%r12, %rbp
               	subq	%rbp, %rcx
               	leaq	(%r13,%rbx), %rbp
               	xorq	%rbp, %rcx
               	leaq	(%r13,%r13,2), %rbp
               	addq	%rbp, %rcx
               	movq	%rcx, %rbp
               	shrq	$0x3, %rbp
               	xorq	%r13, %rbp
               	subq	%rbp, %rcx
               	leaq	(%r14,%rbx), %rbp
               	xorq	%rbp, %rcx
               	leaq	(%r14,%r14,2), %rbp
               	addq	%rbp, %rcx
               	movq	%rcx, %rbp
               	shrq	$0x3, %rbp
               	xorq	%r14, %rbp
               	subq	%rbp, %rcx
               	addq	%r15, %rbx
               	xorq	%rbx, %rcx
               	leaq	(%r15,%r15,2), %rbx
               	addq	%rbx, %rcx
               	movq	%rcx, %rbx
               	shrq	$0x3, %rbx
               	xorq	%r15, %rbx
               	subq	%rbx, %rcx
               	jmp	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	jmp	<addr>

<main>:
               	subq	$0x50, %rsp
               	pushq	%rbx
               	leaq	0x10(%rsp), %rdi
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
               	leaq	0x10(%rsp), %rdi
               	movl	$0x29, %esi
               	callq	<addr>
               	xorq	%rax, %rbx
               	leaq	0x10(%rsp), %rdi
               	movl	$0x28, %esi
               	callq	<addr>
               	xorq	%rbx, %rax
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	andq	$0xff, %rax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
