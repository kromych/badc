
aggregate_result_alignment.x64:	file format elf64-x86-64

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

<make_m16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movsbq	%sil, %rsi
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<make_r16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsbq	%dil, %rsi
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	-0x10(%rbp), %rax
               	movzbq	-0xf(%rbp), %rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movzbq	-0xe(%rbp), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movzbq	-0xd(%rbp), %rcx
               	shlq	$0x18, %rcx
               	orq	%rcx, %rax
               	movzbq	-0xc(%rbp), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movzbq	-0xb(%rbp), %rcx
               	shlq	$0x28, %rcx
               	orq	%rcx, %rax
               	movzbq	-0xa(%rbp), %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	movzbq	-0x9(%rbp), %rcx
               	shlq	$0x38, %rcx
               	orq	%rcx, %rax
               	movzbq	-0x8(%rbp), %rcx
               	movzbq	-0x7(%rbp), %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	movzbq	-0x6(%rbp), %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movzbq	-0x5(%rbp), %rdx
               	shlq	$0x18, %rdx
               	orq	%rdx, %rcx
               	movzbq	-0x4(%rbp), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movzbq	-0x3(%rbp), %rdx
               	shlq	$0x28, %rdx
               	orq	%rdx, %rcx
               	movzbq	-0x2(%rbp), %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rcx
               	movzbq	-0x1(%rbp), %rdx
               	shlq	$0x38, %rdx
               	orq	%rcx, %rdx
               	leave
               	retq

<make_m32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movsbq	%sil, %rsi
               	leaq	(%rsp), %rdi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rcx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	leave
               	retq

<make_m32_args>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x60(%rbp)
               	leaq	(%rsp), %rdi
               	movq	0x10(%rbp), %rax
               	addq	$0xd, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	subq	$0x24, %rax
               	movsbq	%al, %rsi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x60(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rcx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	leave
               	retq

<results>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movsbq	%dil, %rbx
               	leaq	0x80(%rsp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r12
               	andq	$0xf, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0xa0(%rsp), %rcx
               	movb	%al, 0xa0(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x8, %rsi
               	movb	%sil, 0xa1(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	movb	%sil, 0xa2(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x18, %rsi
               	movb	%sil, 0xa3(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	movb	%sil, 0xa4(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x28, %rsi
               	movb	%sil, 0xa5(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x30, %rsi
               	movb	%sil, 0xa6(%rsp)
               	shrq	$0x38, %rax
               	movb	%al, 0xa7(%rsp)
               	movb	%dl, 0xa8(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	movb	%al, 0xa9(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x10, %rax
               	movb	%al, 0xaa(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x18, %rax
               	movb	%al, 0xab(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x20, %rax
               	movb	%al, 0xac(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x28, %rax
               	movb	%al, 0xad(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x30, %rax
               	movb	%al, 0xae(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x38, %rax
               	movb	%al, 0xaf(%rsp)
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	addq	%rax, %r12
               	leaq	(%rsp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	andq	$0x1f, %rax
               	addq	%r12, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x3e8, %rax            # imm = 0x3E8
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	0xb0(%rsp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movsbq	0xcf(%rsp), %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rdx, %rax
               	shrq	$0x38, %rax
               	movsbq	%al, %rax
               	addq	%rax, %r12
               	leaq	0x40(%rsp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movsbq	0x7f(%rsp), %rax
               	addq	%r12, %rax
               	leaq	(%rbx,%rbx,2), %rcx
               	subq	%rcx, %rax
               	jmp	<addr>

<probe2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x100, %rsp            # imm = 0x100
               	andq	$-0x20, %rsp
               	movl	$0x3, %esi
               	movq	%rsi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	(%rsp), %rdi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	movl	$0x4, %r9d
               	movl	$0x5, %eax
               	movl	$0x6, %r8d
               	movl	$0x7, %ebx
               	movl	$0x8, %r12d
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%r8, 0x8(%rsp)
               	movq	%rbx, 0x10(%rsp)
               	movq	%r12, 0x18(%rsp)
               	movq	%rsi, %r8
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	(%rsp), %rax
               	movq	%rax, %rbx
               	andq	$0x1f, %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %rdx
               	subq	%rdx, %rcx
               	leaq	(%rax,%rcx), %r12
               	leaq	0xc0(%rsp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	leaq	0xc0(%rsp), %rax
               	andq	$0xf, %rax
               	addq	%rax, %r12
               	movl	$0x3, %edi
               	callq	<addr>
               	leaq	0xe0(%rsp), %rcx
               	movb	%al, 0xe0(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x8, %rsi
               	movb	%sil, 0xe1(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	movb	%sil, 0xe2(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x18, %rsi
               	movb	%sil, 0xe3(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	movb	%sil, 0xe4(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x28, %rsi
               	movb	%sil, 0xe5(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x30, %rsi
               	movb	%sil, 0xe6(%rsp)
               	shrq	$0x38, %rax
               	movb	%al, 0xe7(%rsp)
               	movb	%dl, 0xe8(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	movb	%al, 0xe9(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x10, %rax
               	movb	%al, 0xea(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x18, %rax
               	movb	%al, 0xeb(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x20, %rax
               	movb	%al, 0xec(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x28, %rax
               	movb	%al, 0xed(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x30, %rax
               	movb	%al, 0xee(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x38, %rax
               	movb	%al, 0xef(%rsp)
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	addq	%rax, %r12
               	leaq	0x40(%rsp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	andq	$0x1f, %rax
               	addq	%r12, %rax
               	imulq	$0x64, %rbx, %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	0x80(%rsp), %rdi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %eax
               	movl	$0x6, %esi
               	movl	$0x7, %r12d
               	movl	$0x8, %r13d
               	movl	$0x3, %r14d
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	%r14, %rsi
               	callq	<addr>
               	addq	$0x20, %rsp
               	movsbq	0x85(%rsp), %rax
               	addq	%rbx, %rax
               	subq	$0x3, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<probe3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x4, %esi
               	movq	%rsi, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	shlq	%rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	andq	$0xf, %rax
               	addq	%rax, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	0x60(%rsp), %rcx
               	movb	%al, 0x60(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x8, %rsi
               	movb	%sil, 0x61(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	movb	%sil, 0x62(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x18, %rsi
               	movb	%sil, 0x63(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	movb	%sil, 0x64(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x28, %rsi
               	movb	%sil, 0x65(%rsp)
               	movq	%rax, %rsi
               	shrq	$0x30, %rsi
               	movb	%sil, 0x66(%rsp)
               	shrq	$0x38, %rax
               	movb	%al, 0x67(%rsp)
               	movb	%dl, 0x68(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	movb	%al, 0x69(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x10, %rax
               	movb	%al, 0x6a(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x18, %rax
               	movb	%al, 0x6b(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x20, %rax
               	movb	%al, 0x6c(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x28, %rax
               	movb	%al, 0x6d(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x30, %rax
               	movb	%al, 0x6e(%rsp)
               	movq	%rdx, %rax
               	shrq	$0x38, %rax
               	movb	%al, 0x6f(%rsp)
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	addq	%rax, %rbx
               	leaq	(%rsp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	andq	$0x1f, %rax
               	addq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<probe_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %r12
               	movsbq	%sil, %rbx
               	movq	%r12, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r13
               	subq	%r11, %r13
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r13, %rsp
               	movq	%r13, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, %r14
               	andq	$0xf, %r14
               	movq	%rbx, %rdi
               	callq	<addr>
               	movb	%al, -0x20(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	movb	%cl, -0x1f(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	movb	%cl, -0x1e(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x18, %rcx
               	movb	%cl, -0x1d(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	movb	%cl, -0x1c(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x28, %rcx
               	movb	%cl, -0x1b(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x30, %rcx
               	movb	%cl, -0x1a(%rbp)
               	shrq	$0x38, %rax
               	movb	%al, -0x19(%rbp)
               	movb	%dl, -0x18(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	movb	%al, -0x17(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x10, %rax
               	movb	%al, -0x16(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x18, %rax
               	movb	%al, -0x15(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x20, %rax
               	movb	%al, -0x14(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x28, %rax
               	movb	%al, -0x13(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x30, %rax
               	movb	%al, -0x12(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x38, %rax
               	movb	%al, -0x11(%rbp)
               	leaq	-0x20(%rbp), %rax
               	andq	$0xf, %rax
               	addq	%r14, %rax
               	leaq	-0x1(%r12), %rcx
               	movslq	%ecx, %rcx
               	movsbq	(%r13,%rcx), %rcx
               	addq	%rcx, %rax
               	subq	%rbx, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	movq	%rdi, -0x8(%rbp)
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	subq	$0x2, %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	andq	$0xf, %rax
               	addq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movb	%al, -0x20(%rbp)
               	movq	%rax, %rsi
               	shrq	$0x8, %rsi
               	movb	%sil, -0x1f(%rbp)
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	movb	%sil, -0x1e(%rbp)
               	movq	%rax, %rsi
               	shrq	$0x18, %rsi
               	movb	%sil, -0x1d(%rbp)
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	movb	%sil, -0x1c(%rbp)
               	movq	%rax, %rsi
               	shrq	$0x28, %rsi
               	movb	%sil, -0x1b(%rbp)
               	movq	%rax, %rsi
               	shrq	$0x30, %rsi
               	movb	%sil, -0x1a(%rbp)
               	shrq	$0x38, %rax
               	movb	%al, -0x19(%rbp)
               	movb	%dl, -0x18(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	movb	%al, -0x17(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x10, %rax
               	movb	%al, -0x16(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x18, %rax
               	movb	%al, -0x15(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x20, %rax
               	movb	%al, -0x14(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x28, %rax
               	movb	%al, -0x13(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x30, %rax
               	movb	%al, -0x12(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x38, %rax
               	movb	%al, -0x11(%rbp)
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	addq	%rbx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
