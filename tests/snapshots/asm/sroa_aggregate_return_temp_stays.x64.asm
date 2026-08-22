
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
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %ecx
               	shlq	$0x2, %rcx
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	shrq	$0x1e, %rdx
               	orq	%rdx, %rcx
               	movl	%eax, %eax
               	shlq	$0x2, %rax
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	leaq	-0x10(%rbp), %rdx
               	movl	(%rdx), %esi
               	movl	0x4(%rdx), %edx
               	movl	%eax, %eax
               	movl	%esi, %esi
               	addq	%rsi, %rax
               	movl	%eax, %eax
               	movl	%ecx, %esi
               	movl	%edx, %edx
               	addq	%rsi, %rdx
               	movl	%edx, %edx
               	movl	%eax, %eax
               	movl	%edx, %edx
               	movl	%eax, %eax
               	movl	%edx, %edx
               	movl	%edx, %esi
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rsi
               	jae	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, %eax
               	movl	%edx, %edx
               	movl	%eax, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>

<times9>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %ecx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	shrq	$0x1d, %rdx
               	orq	%rdx, %rcx
               	movl	%eax, %eax
               	shlq	$0x3, %rax
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	leaq	-0x10(%rbp), %rdx
               	movl	(%rdx), %esi
               	movl	0x4(%rdx), %edx
               	movl	%eax, %eax
               	movl	%esi, %esi
               	addq	%rsi, %rax
               	movl	%eax, %eax
               	movl	%ecx, %esi
               	movl	%edx, %edx
               	addq	%rsi, %rdx
               	movl	%edx, %edx
               	movl	%eax, %eax
               	movl	%edx, %edx
               	movl	%eax, %eax
               	movl	%edx, %edx
               	movl	%edx, %esi
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rsi
               	jae	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, %eax
               	movl	%edx, %edx
               	movl	%eax, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
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
               	shlq	$0x7, %rdx
               	movl	%edx, %edx
               	movl	%eax, %esi
               	shrq	$0x19, %rsi
               	orq	%rsi, %rdx
               	movl	%ecx, %ecx
               	shrq	$0x19, %rcx
               	movl	%eax, %eax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edx, %ecx
               	movl	%eax, %edx
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %ecx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	shrq	$0xf, %rdx
               	orq	%rdx, %rcx
               	movl	%eax, %eax
               	shlq	$0x11, %rax
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	leaq	0x10(%rbx), %rax
               	movl	(%rbx), %esi
               	movl	0x4(%rbx), %r9d
               	movl	(%rax), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%r9d, %r9d
               	xorq	%r9, %rsi
               	movl	%esi, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	leaq	0x8(%rbx), %rsi
               	movl	(%rsi), %r9d
               	movl	0x4(%rsi), %esi
               	movl	(%rax), %r12d
               	movl	%r9d, %r9d
               	xorq	%r12, %r9
               	movl	%r9d, (%rax)
               	movl	0x4(%rax), %r9d
               	movl	%esi, %esi
               	xorq	%r9, %rsi
               	movl	%esi, 0x4(%rax)
               	leaq	0x8(%rbx), %rax
               	leaq	0x10(%rbx), %rsi
               	movl	(%rsi), %r9d
               	movl	0x4(%rsi), %esi
               	movl	(%rax), %r12d
               	movl	%r9d, %r9d
               	xorq	%r12, %r9
               	movl	%r9d, (%rax)
               	movl	0x4(%rax), %r9d
               	movl	%esi, %esi
               	xorq	%r9, %rsi
               	movl	%esi, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %esi
               	movl	0x4(%rax), %eax
               	movl	(%rbx), %r9d
               	movl	%esi, %esi
               	xorq	%r9, %rsi
               	movl	%esi, (%rbx)
               	movl	0x4(%rbx), %esi
               	movl	%eax, %eax
               	xorq	%rsi, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	movl	(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	shrq	$0x13, %rsi
               	movl	%edx, %edi
               	shlq	$0xd, %rdi
               	movl	%edi, %edi
               	orq	%rdi, %rsi
               	movl	%ecx, %ecx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x10(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	(%rcx), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x3ef, %edx            # imm = 0x3EF
               	movl	%edx, 0x4(%rax)
               	leaq	-0x28(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rax
               	leaq	0x8(%rax), %rcx
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0xff, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x28(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x28(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rax
               	leaq	0x18(%rax), %rcx
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x28(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
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
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	shlq	$0x1f, %rcx
               	shlq	%rcx
               	movl	0x4(%rax), %eax
               	orq	%rcx, %rax
               	movabsq	$0xba18b516cb227f9, %r11 # imm = 0xBA18B516CB227F9
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
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
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
