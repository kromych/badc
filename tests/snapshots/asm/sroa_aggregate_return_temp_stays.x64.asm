
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
               	movl	%edx, %edx
               	shlq	$0x2, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0x1e, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, %ecx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %eax
               	movl	%edx, %edx
               	movl	%esi, %esi
               	addq	%rsi, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	movl	%eax, %eax
               	movl	%esi, %esi
               	movl	%eax, %edi
               	movl	%esi, %eax
               	movl	%edi, %esi
               	movl	%esi, %edi
               	cmpl	%edx, %edi
               	jae	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, %eax
               	movl	%esi, %edx
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
               	movl	%edx, %edx
               	shlq	$0x3, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0x1d, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, %ecx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %eax
               	movl	%edx, %edx
               	movl	%esi, %esi
               	addq	%rsi, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	movl	%eax, %eax
               	movl	%esi, %esi
               	movl	%eax, %edi
               	movl	%esi, %eax
               	movl	%edi, %esi
               	movl	%esi, %edi
               	cmpl	%edx, %edi
               	jae	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, %eax
               	movl	%esi, %edx
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
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x18(%rbp), %rdi
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	movl	%eax, (%rdi)
               	movl	%ecx, 0x4(%rdi)
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
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %ecx
               	movl	%edx, %esi
               	movl	%ecx, %edi
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %r8d
               	movl	(%rcx), %r9d
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %r8d
               	movl	0x4(%rax), %r9d
               	movl	(%rdx), %r12d
               	movl	%r8d, %r8d
               	xorq	%r12, %r8
               	movl	%r8d, (%rdx)
               	movl	0x4(%rdx), %r8d
               	movl	%r9d, %r9d
               	xorq	%r9, %r8
               	movl	%r8d, 0x4(%rdx)
               	movl	(%rcx), %r8d
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %r9d
               	movl	%r8d, %r8d
               	xorq	%r9, %r8
               	movl	%r8d, (%rax)
               	movl	0x4(%rax), %r8d
               	movl	%ecx, %ecx
               	xorq	%r8, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	%esi, %edx
               	xorq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rax), %ecx
               	movl	%edi, %edx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %r8
               	shrq	$0x13, %r8
               	movl	%edx, %edi
               	movq	%rdi, %r9
               	shlq	$0xd, %r9
               	movl	%r9d, %r9d
               	orq	%r9, %r8
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%r8d, %edx
               	movl	%ecx, %esi
               	movl	%edx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	movl	%edx, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
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
