
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
               	xorl	%eax, %eax
               	movq	(%rdi), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%r10, %rdx
               	incq	%rdx
               	movq	0x8(%rdi), %rcx
               	leaq	0x2(%rcx), %rsi
               	movq	0x10(%rdi), %rcx
               	leaq	0x3(%rcx), %r8
               	movq	0x18(%rdi), %rcx
               	leaq	0x4(%rcx), %r9
               	movq	0x20(%rdi), %r10
               	addq	$0x5, %r10
               	movq	0x28(%rdi), %r11
               	movq	%r11, 0x70(%rsp)
               	addq	$0x6, %r11
               	movq	0x30(%rdi), %r15
               	movq	%r15, 0x68(%rsp)
               	addq	$0x7, %r15
               	movq	%r15, 0x58(%rsp)
               	movq	0x38(%rdi), %r15
               	movq	%r15, 0x60(%rsp)
               	addq	$0x8, %r15
               	movq	%r15, 0x50(%rsp)
               	movq	0x78(%rsp), %r15
               	xorq	%rcx, %r15
               	movq	%r15, 0x78(%rsp)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, %r15
               	xorq	0x70(%rsp), %r15
               	movq	%r15, 0x70(%rsp)
               	movq	0x10(%rdi), %rbx
               	movq	%rbx, %r15
               	xorq	0x68(%rsp), %r15
               	movq	%r15, 0x68(%rsp)
               	movq	0x18(%rdi), %r12
               	movq	%r12, %r15
               	xorq	0x60(%rsp), %r15
               	movq	%r15, 0x60(%rsp)
               	movq	0x20(%rdi), %r13
               	movq	(%rdi), %r14
               	leaq	(%r13,%r14), %r15
               	movq	%r15, 0x48(%rsp)
               	movq	0x28(%rdi), %r13
               	leaq	(%r13,%rcx), %r15
               	movq	%r15, 0x40(%rsp)
               	movq	0x30(%rdi), %rcx
               	leaq	(%rcx,%rbx), %r15
               	movq	%r15, 0x38(%rsp)
               	movq	0x38(%rdi), %rcx
               	leaq	(%rcx,%r12), %r15
               	movq	%r15, 0x30(%rsp)
               	xorl	%ecx, %ecx
               	leaq	(%rdx,%rdx,2), %rbx
               	leaq	(%rsi,%rsi,2), %r12
               	leaq	(%r8,%r8,2), %r13
               	leaq	(%r9,%r9,2), %r14
               	leaq	(%r10,%r10,2), %r15
               	leaq	(%r11,%r11,2), %rbp
               	leaq	(%rdx,%rcx), %rdi
               	xorq	%rax, %rdi
               	leaq	(%rdi,%rbx), %rax
               	movq	%rax, %rdi
               	shrq	$0x3, %rdi
               	xorq	%rdx, %rdi
               	subq	%rdi, %rax
               	leaq	(%rsi,%rcx), %rdi
               	xorq	%rdi, %rax
               	addq	%r12, %rax
               	movq	%rax, %rdi
               	shrq	$0x3, %rdi
               	xorq	%rsi, %rdi
               	subq	%rdi, %rax
               	leaq	(%r8,%rcx), %rdi
               	xorq	%rdi, %rax
               	addq	%r13, %rax
               	movq	%rax, %rdi
               	shrq	$0x3, %rdi
               	xorq	%r8, %rdi
               	subq	%rdi, %rax
               	leaq	(%r9,%rcx), %rdi
               	xorq	%rdi, %rax
               	addq	%r14, %rax
               	movq	%rax, %rdi
               	shrq	$0x3, %rdi
               	xorq	%r9, %rdi
               	subq	%rdi, %rax
               	leaq	(%r10,%rcx), %rdi
               	xorq	%rdi, %rax
               	addq	%r15, %rax
               	movq	%rax, %rdi
               	shrq	$0x3, %rdi
               	xorq	%r10, %rdi
               	subq	%rdi, %rax
               	leaq	(%r11,%rcx), %rdi
               	xorq	%rdi, %rax
               	addq	%rbp, %rax
               	movq	%rax, %rdi
               	shrq	$0x3, %rdi
               	xorq	%r11, %rdi
               	subq	%rdi, %rax
               	incq	%rcx
               	cmpl	$0x64, %ecx
               	jb	<addr>
               	xorq	%rsi, %rdx
               	xorq	%r8, %rdx
               	xorq	%r9, %rdx
               	xorq	%r10, %rdx
               	xorq	%r11, %rdx
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
               	movq	(%rdi), %rax
               	leaq	0x1(%rax), %r11
               	movq	0x8(%rdi), %rcx
               	leaq	0x2(%rcx), %rbx
               	movq	0x10(%rdi), %rcx
               	leaq	0x3(%rcx), %r12
               	movq	0x18(%rdi), %rcx
               	leaq	0x4(%rcx), %r13
               	movq	0x20(%rdi), %rdx
               	addq	$0x5, %rdx
               	movq	0x28(%rdi), %r14
               	leaq	0x6(%r14), %r8
               	movq	0x30(%rdi), %r15
               	leaq	0x7(%r15), %r9
               	movq	0x38(%rdi), %rbp
               	leaq	0x8(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rax, %r10
               	xorq	%rcx, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0x8(%rdi), %rax
               	movq	%rax, %r10
               	xorq	%r14, %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	0x10(%rdi), %rcx
               	movq	%rcx, %r14
               	xorq	%r15, %r14
               	movq	%r14, 0x88(%rsp)
               	movq	0x18(%rdi), %r14
               	xorq	%r14, %rbp
               	movq	0x20(%rdi), %r15
               	movq	%r10, 0x38(%rsp)
               	movq	(%rdi), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	%r15, %r10
               	addq	0x80(%rsp), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x28(%rdi), %r15
               	leaq	(%r15,%rax), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	0x30(%rdi), %rax
               	leaq	(%rax,%rcx), %r15
               	movq	%r15, 0x70(%rsp)
               	movq	0x38(%rdi), %rax
               	leaq	(%rax,%r14), %r15
               	testl	%esi, %esi
               	jne	<addr>
               	movq	%r11, %rdi
               	xorq	%r15, %rdi
               	movq	<rip>, %rax # <addr>
               	movq	%rsi, 0x40(%rsp)
               	movq	%r11, 0x68(%rsp)
               	movq	%rdx, 0x60(%rsp)
               	movq	%r8, 0x58(%rsp)
               	movq	%r9, 0x50(%rsp)
               	movq	%r10, 0x48(%rsp)
               	callq	*%rax
               	movq	0x40(%rsp), %rsi
               	movq	0x68(%rsp), %r11
               	movq	0x60(%rsp), %rdx
               	movq	0x58(%rsp), %r8
               	movq	0x50(%rsp), %r9
               	movq	0x48(%rsp), %r10
               	testb	$0x1, %sil
               	je	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	%eax, %eax
               	leaq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	leaq	(%rdx,%rdx,2), %rdi
               	addq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x3, %rdi
               	xorq	%rdx, %rdi
               	subq	%rdi, %rcx
               	leaq	(%r8,%rax), %rdi
               	xorq	%rdi, %rcx
               	leaq	(%r8,%r8,2), %rdi
               	addq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x3, %rdi
               	xorq	%r8, %rdi
               	subq	%rdi, %rcx
               	leaq	(%r9,%rax), %rdi
               	xorq	%rdi, %rcx
               	leaq	(%r9,%r9,2), %rdi
               	addq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x3, %rdi
               	xorq	%r9, %rdi
               	subq	%rdi, %rcx
               	leaq	(%r10,%rax), %rdi
               	xorq	%rdi, %rcx
               	leaq	(%r10,%r10,2), %rdi
               	addq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x3, %rdi
               	xorq	%r10, %rdi
               	subq	%rdi, %rcx
               	incq	%rax
               	subl	$0x1, %esi
               	jne	<addr>
               	movq	%r11, %rax
               	xorq	%rbx, %rax
               	xorq	%r12, %rax
               	xorq	%r13, %rax
               	xorq	%rdx, %rax
               	xorq	%r8, %rax
               	xorq	%r9, %rax
               	xorq	%r10, %rax
               	xorq	0x98(%rsp), %rax
               	xorq	0x90(%rsp), %rax
               	xorq	0x88(%rsp), %rax
               	xorq	%rbp, %rax
               	xorq	0x80(%rsp), %rax
               	xorq	0x78(%rsp), %rax
               	xorq	0x70(%rsp), %rax
               	xorq	%r15, %rax
               	xorq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x78, %rsp
               	retq
               	movl	%eax, %edi
               	leaq	(%r11,%rdi), %r14
               	xorq	%r14, %rcx
               	leaq	(%r11,%r11,2), %r14
               	addq	%r14, %rcx
               	movq	%rcx, %r14
               	shrq	$0x3, %r14
               	xorq	%r11, %r14
               	subq	%r14, %rcx
               	leaq	(%rbx,%rdi), %r14
               	xorq	%r14, %rcx
               	leaq	(%rbx,%rbx,2), %r14
               	addq	%r14, %rcx
               	movq	%rcx, %r14
               	shrq	$0x3, %r14
               	xorq	%rbx, %r14
               	subq	%r14, %rcx
               	leaq	(%r12,%rdi), %r14
               	xorq	%r14, %rcx
               	leaq	(%r12,%r12,2), %r14
               	addq	%r14, %rcx
               	movq	%rcx, %r14
               	shrq	$0x3, %r14
               	xorq	%r12, %r14
               	subq	%r14, %rcx
               	addq	%r13, %rdi
               	xorq	%rdi, %rcx
               	leaq	(%r13,%r13,2), %rdi
               	addq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x3, %rdi
               	xorq	%r13, %rdi
               	subq	%rdi, %rcx
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
