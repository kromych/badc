
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
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	shrq	$0x1e, %rsi
               	movq	%rdx, %r8
               	orq	%rsi, %r8
               	shlq	$0x2, %rcx
               	movl	%ecx, %ecx
               	movl	(%rax), %edx
               	movl	0x4(%rax), %edi
               	leaq	(%r8,%rdx), %rax
               	movl	%eax, %eax
               	leaq	(%rcx,%rdi), %rdx
               	movl	%edx, %edx
               	cmpl	%ecx, %edx
               	jae	<addr>
               	incq	%rax
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, %eax
               	movl	%eax, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	movq	(%rcx), %rax
               	leave
               	retq
               	jmp	<addr>

<times9>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	shlq	$0x3, %rdx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	shrq	$0x1d, %rsi
               	movq	%rdx, %r8
               	orq	%rsi, %r8
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	movl	(%rax), %edx
               	movl	0x4(%rax), %edi
               	leaq	(%r8,%rdx), %rax
               	movl	%eax, %eax
               	leaq	(%rcx,%rdi), %rdx
               	movl	%edx, %edx
               	cmpl	%ecx, %edx
               	jae	<addr>
               	incq	%rax
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, %eax
               	movl	%eax, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	movq	(%rcx), %rax
               	leave
               	retq
               	jmp	<addr>

<step>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
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
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	shrq	$0x19, %rsi
               	orq	%rsi, %rdx
               	shrq	$0x19, %rax
               	shlq	$0x7, %rcx
               	movl	%ecx, %ecx
               	orq	%rcx, %rax
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
               	leaq	0x8(%rbx), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %eax
               	shlq	$0x11, %rdx
               	movl	%edx, %edx
               	movq	%rax, %rsi
               	shrq	$0xf, %rsi
               	movq	%rdx, %rdi
               	orq	%rsi, %rdi
               	shlq	$0x11, %rax
               	movl	%eax, %r8d
               	leaq	0x10(%rbx), %rax
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rax), %r13d
               	xorq	%r13, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x8(%rbx), %rcx
               	leaq	0x10(%rbx), %rdx
               	movl	(%rdx), %esi
               	movl	0x4(%rdx), %edx
               	movl	(%rcx), %r13d
               	xorq	%r13, %rsi
               	movl	%esi, (%rcx)
               	movl	0x4(%rcx), %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	(%rbx), %edx
               	xorq	%rdx, %rcx
               	movl	%ecx, (%rbx)
               	movl	0x4(%rbx), %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	movl	(%rax), %ecx
               	xorq	%rdi, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rax), %ecx
               	xorq	%r8, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movq	%rcx, %rsi
               	shrq	$0x13, %rsi
               	movq	%rdx, %rdi
               	shlq	$0xd, %rdi
               	movl	%edi, %edi
               	orq	%rdi, %rsi
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%esi, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	(%rcx), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x3ef, %edx            # imm = 0x3EF
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	0x8(%rax), %rdx
               	movl	$0xff, %esi
               	movl	%ecx, (%rdx)
               	movl	%esi, 0x4(%rdx)
               	leaq	0x10(%rax), %rdx
               	xorq	%rax, %rax
               	movl	%ecx, (%rdx)
               	movl	%eax, 0x4(%rdx)
               	leaq	-0x20(%rbp), %rdi
               	leaq	0x18(%rdi), %rcx
               	movl	%eax, (%rcx)
               	movl	%eax, 0x4(%rcx)
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
               	xorq	%rax, %rax
               	leave
               	retq
