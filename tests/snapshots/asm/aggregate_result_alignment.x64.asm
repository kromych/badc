
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
               	leaq	-0x40(%rbp), %rcx
               	andq	$0xff, %rsi
               	movb	%sil, -0x40(%rbp)
               	movb	%sil, -0x3f(%rbp)
               	movb	%sil, -0x3e(%rbp)
               	movb	%sil, -0x3d(%rbp)
               	movb	%sil, -0x3c(%rbp)
               	movb	%sil, -0x3b(%rbp)
               	movb	%sil, -0x3a(%rbp)
               	movb	%sil, -0x39(%rbp)
               	movb	%sil, -0x38(%rbp)
               	movb	%sil, -0x37(%rbp)
               	movb	%sil, -0x36(%rbp)
               	movb	%sil, -0x35(%rbp)
               	movb	%sil, -0x34(%rbp)
               	movb	%sil, -0x33(%rbp)
               	movb	%sil, -0x32(%rbp)
               	movb	%sil, -0x31(%rbp)
               	movb	%sil, -0x30(%rbp)
               	movb	%sil, -0x2f(%rbp)
               	movb	%sil, -0x2e(%rbp)
               	movb	%sil, -0x2d(%rbp)
               	movb	%sil, -0x2c(%rbp)
               	movb	%sil, -0x2b(%rbp)
               	movb	%sil, -0x2a(%rbp)
               	movb	%sil, -0x29(%rbp)
               	movb	%sil, -0x28(%rbp)
               	movb	%sil, -0x27(%rbp)
               	movb	%sil, -0x26(%rbp)
               	movb	%sil, -0x25(%rbp)
               	movb	%sil, -0x24(%rbp)
               	movb	%sil, -0x23(%rbp)
               	movb	%sil, -0x22(%rbp)
               	movb	%sil, -0x21(%rbp)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movsbq	%dil, %rbx
               	leaq	0x80(%rsp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	leaq	0xa0(%rsp), %rdx
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xa0(%rsp)
               	movb	%al, 0xa1(%rsp)
               	movb	%al, 0xa2(%rsp)
               	movb	%al, 0xa3(%rsp)
               	movb	%al, 0xa4(%rsp)
               	movb	%al, 0xa5(%rsp)
               	movb	%al, 0xa6(%rsp)
               	movb	%al, 0xa7(%rsp)
               	movb	%al, 0xa8(%rsp)
               	movb	%al, 0xa9(%rsp)
               	movb	%al, 0xaa(%rsp)
               	movb	%al, 0xab(%rsp)
               	movb	%al, 0xac(%rsp)
               	movb	%al, 0xad(%rsp)
               	movb	%al, 0xae(%rsp)
               	movb	%al, 0xaf(%rsp)
               	andq	$0xf, %rdx
               	leaq	(%rcx,%rdx), %r12
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
               	leaq	0x40(%rsp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movsbq	0x5f(%rsp), %rax
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	movsbq	%cl, %rcx
               	leaq	(%rax,%rcx), %r12
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
               	leaq	(%r12,%rax), %rcx
               	leaq	0xe0(%rsp), %rdx
               	movb	$0x3, 0xe0(%rsp)
               	movb	$0x3, 0xe1(%rsp)
               	movb	$0x3, 0xe2(%rsp)
               	movb	$0x3, 0xe3(%rsp)
               	movb	$0x3, 0xe4(%rsp)
               	movb	$0x3, 0xe5(%rsp)
               	movb	$0x3, 0xe6(%rsp)
               	movb	$0x3, 0xe7(%rsp)
               	movb	$0x3, 0xe8(%rsp)
               	movb	$0x3, 0xe9(%rsp)
               	movb	$0x3, 0xea(%rsp)
               	movb	$0x3, 0xeb(%rsp)
               	movb	$0x3, 0xec(%rsp)
               	movb	$0x3, 0xed(%rsp)
               	movb	$0x3, 0xee(%rsp)
               	movb	$0x3, 0xef(%rsp)
               	andq	$0xf, %rdx
               	leaq	(%rcx,%rdx), %r12
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
               	leaq	(%rbx,%rax), %rcx
               	leaq	0x60(%rsp), %rdx
               	movb	$0x4, 0x60(%rsp)
               	movb	$0x4, 0x61(%rsp)
               	movb	$0x4, 0x62(%rsp)
               	movb	$0x4, 0x63(%rsp)
               	movb	$0x4, 0x64(%rsp)
               	movb	$0x4, 0x65(%rsp)
               	movb	$0x4, 0x66(%rsp)
               	movb	$0x4, 0x67(%rsp)
               	movb	$0x4, 0x68(%rsp)
               	movb	$0x4, 0x69(%rsp)
               	movb	$0x4, 0x6a(%rsp)
               	movb	$0x4, 0x6b(%rsp)
               	movb	$0x4, 0x6c(%rsp)
               	movb	$0x4, 0x6d(%rsp)
               	movb	$0x4, 0x6e(%rsp)
               	movb	$0x4, 0x6f(%rsp)
               	andq	$0xf, %rdx
               	leaq	(%rcx,%rdx), %rbx
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
               	subq	$0x48, %rsp
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
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x20(%rbp)
               	movb	%al, -0x1f(%rbp)
               	movb	%al, -0x1e(%rbp)
               	movb	%al, -0x1d(%rbp)
               	movb	%al, -0x1c(%rbp)
               	movb	%al, -0x1b(%rbp)
               	movb	%al, -0x1a(%rbp)
               	movb	%al, -0x19(%rbp)
               	movb	%al, -0x18(%rbp)
               	movb	%al, -0x17(%rbp)
               	movb	%al, -0x16(%rbp)
               	movb	%al, -0x15(%rbp)
               	movb	%al, -0x14(%rbp)
               	movb	%al, -0x13(%rbp)
               	movb	%al, -0x12(%rbp)
               	movb	%al, -0x11(%rbp)
               	andq	$0xf, %rdx
               	leaq	(%rcx,%rdx), %rax
               	leaq	-0x1(%r12), %rcx
               	movslq	%ecx, %rcx
               	movsbq	(%r13,%rcx), %rcx
               	addq	%rcx, %rax
               	subq	%rbx, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	leaq	(%rbx,%rax), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movl	$0x2, %eax
               	movb	%al, -0x20(%rbp)
               	movb	%al, -0x1f(%rbp)
               	movb	%al, -0x1e(%rbp)
               	movb	%al, -0x1d(%rbp)
               	movb	%al, -0x1c(%rbp)
               	movb	%al, -0x1b(%rbp)
               	movb	%al, -0x1a(%rbp)
               	movb	%al, -0x19(%rbp)
               	movb	%al, -0x18(%rbp)
               	movb	%al, -0x17(%rbp)
               	movb	%al, -0x16(%rbp)
               	movb	%al, -0x15(%rbp)
               	movb	%al, -0x14(%rbp)
               	movb	%al, -0x13(%rbp)
               	movb	%al, -0x12(%rbp)
               	movb	%al, -0x11(%rbp)
               	andq	$0xf, %rdx
               	addq	%rdx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
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
