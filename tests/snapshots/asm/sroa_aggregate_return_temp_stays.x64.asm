
sroa_aggregate_return_temp_stays.x64:	file format elf64-x86-64

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

<times5>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	shlq	$0x2, %rdx
               	movq	%rcx, %rsi
               	shrq	$0x1e, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x2, %rcx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	leaq	(%rdx,%rsi), %rax
               	leaq	(%rcx,%rdi), %rdx
               	cmpl	%ecx, %edx
               	jae	<addr>
               	incq	%rax
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	movq	(%rcx), %rax
               	leave
               	retq

<times9>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	shlq	$0x3, %rdx
               	movq	%rcx, %rsi
               	shrq	$0x1d, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x3, %rcx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	leaq	(%rdx,%rsi), %rax
               	leaq	(%rcx,%rdi), %rdx
               	cmpl	%ecx, %edx
               	jae	<addr>
               	incq	%rax
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	movq	(%rcx), %rax
               	leave
               	retq

<step>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %eax
               	movl	0x4(%rcx), %ecx
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	movq	%rcx, %rsi
               	shrq	$0x19, %rsi
               	orq	%rsi, %rdx
               	movq	%rax, %rsi
               	shrq	$0x19, %rsi
               	movq	%rcx, %rax
               	shlq	$0x7, %rax
               	orq	%rsi, %rax
               	leaq	-0x18(%rbp), %rdi
               	movl	%edx, (%rdi)
               	movl	%eax, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	shlq	$0x11, %rdx
               	movq	%rcx, %rsi
               	shrq	$0xf, %rsi
               	movq	%rdx, %rdi
               	orq	%rsi, %rdi
               	shlq	$0x11, %rcx
               	leaq	0x10(%rbx), %rdx
               	movl	(%rbx), %esi
               	movl	0x4(%rbx), %r8d
               	movl	(%rdx), %r9d
               	xorq	%r9, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	xorq	%r8, %rsi
               	movl	%esi, 0x4(%rdx)
               	leaq	0x18(%rbx), %rsi
               	movl	(%rax), %r8d
               	movl	0x4(%rax), %r9d
               	movl	(%rsi), %r12d
               	xorq	%r12, %r8
               	movl	%r8d, (%rsi)
               	movl	0x4(%rsi), %r8d
               	xorq	%r9, %r8
               	movl	%r8d, 0x4(%rsi)
               	movl	(%rdx), %r8d
               	movl	0x4(%rdx), %edx
               	movl	(%rax), %r9d
               	xorq	%r9, %r8
               	movl	%r8d, (%rax)
               	movl	0x4(%rax), %r8d
               	xorq	%r8, %rdx
               	movl	%edx, 0x4(%rax)
               	movl	(%rsi), %eax
               	movl	0x4(%rsi), %edx
               	movl	(%rbx), %esi
               	xorq	%rsi, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	xorq	%rdx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	movl	(%rax), %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movq	%rcx, %rdi
               	shrq	$0x13, %rdi
               	movq	%rdx, %rsi
               	shlq	$0xd, %rsi
               	orq	%rdi, %rsi
               	shlq	$0xd, %rcx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%esi, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	popq	%rbx
               	popq	%r12
               	movq	(%rcx), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x20(%rbp), %rax
               	xorl	%ecx, %ecx
               	movl	$0x3ef, %edx            # imm = 0x3EF
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	0x8(%rax), %rdx
               	movl	$0xff, %esi
               	movl	%ecx, (%rdx)
               	movl	%esi, 0x4(%rdx)
               	addq	$0x10, %rax
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rdi
               	leaq	0x18(%rdi), %rax
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movl	(%rax), %ecx
               	shlq	$0x1f, %rcx
               	shlq	%rcx
               	movl	0x4(%rax), %eax
               	orq	%rcx, %rax
               	movabsq	$0x7a7040a5a323c9d6, %r11 # imm = 0x7A7040A5A323C9D6
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	shlq	$0x1f, %rcx
               	shlq	%rcx
               	movl	0x4(%rax), %edx
               	orq	%rdx, %rcx
               	movabsq	$0xba18b516cb227f9, %r11 # imm = 0xBA18B516CB227F9
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	addq	$0x18, %rax
               	movl	(%rax), %ecx
               	shlq	$0x1f, %rcx
               	shlq	%rcx
               	movl	0x4(%rax), %eax
               	orq	%rcx, %rax
               	movabsq	$0x194f95cf3210cb5a, %r11 # imm = 0x194F95CF3210CB5A
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
