
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %rbx
               	leaq	0x8(%rbx), %r12
               	movq	%r12, %rdi
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
               	movq	%rcx, %rax
               	movl	(%r12), %ecx
               	movl	0x4(%r12), %eax
               	movl	%ecx, %ecx
               	shlq	$0x11, %rcx
               	movl	%ecx, %edx
               	movl	%eax, %ecx
               	movq	%rcx, %rsi
               	shrq	$0xf, %rsi
               	orq	%rsi, %rdx
               	movq	%rcx, %rax
               	shlq	$0x11, %rax
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	movl	%eax, %eax
               	movl	%ecx, %edx
               	movl	%eax, %esi
               	leaq	0x10(%rbx), %rax
               	movl	(%rbx), %ecx
               	movl	0x4(%rbx), %r9d
               	movl	(%rax), %r12d
               	movl	%ecx, %ecx
               	xorq	%r12, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rax), %ecx
               	movl	%r9d, %r9d
               	xorq	%r9, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rcx
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %r9d
               	movl	0x4(%rax), %r12d
               	movl	(%rcx), %r13d
               	movl	%r9d, %r9d
               	xorq	%r13, %r9
               	movl	%r9d, (%rcx)
               	movl	0x4(%rcx), %r9d
               	movl	%r12d, %r12d
               	xorq	%r12, %r9
               	movl	%r9d, 0x4(%rcx)
               	leaq	0x10(%rbx), %rcx
               	movl	(%rcx), %r9d
               	movl	0x4(%rcx), %r12d
               	movl	(%rax), %r13d
               	movl	%r9d, %r9d
               	xorq	%r13, %r9
               	movl	%r9d, (%rax)
               	movl	0x4(%rax), %r9d
               	movl	%r12d, %r12d
               	xorq	%r12, %r9
               	movl	%r9d, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %r9d
               	movl	0x4(%rax), %r12d
               	movl	(%rbx), %r13d
               	movl	%r9d, %r9d
               	xorq	%r13, %r9
               	movl	%r9d, (%rbx)
               	movl	0x4(%rbx), %r9d
               	movl	%r12d, %r12d
               	xorq	%r12, %r9
               	movl	%r9d, 0x4(%rbx)
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
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
               	leaq	-0x10(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	(%rcx), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	movl	$0x3ef, %edx            # imm = 0x3EF
               	movl	%edx, 0x4(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rdx
               	leaq	0x8(%rcx), %rdx
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0xff, %esi
               	movl	%esi, 0x4(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	popq	%rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	0x10(%rdx), %rsi
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x28(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	popq	%rcx
               	addq	$0x18, %rdx
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x28(%rbp), %rbx
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rax
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movl	(%rbx), %eax
               	shlq	$0x1f, %rax
               	shlq	%rax
               	movl	0x4(%rbx), %ecx
               	orq	%rcx, %rax
               	movabsq	$0x7a7040a5a323c9d6, %r11 # imm = 0x7A7040A5A323C9D6
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
