
sroa_aggregate_return_temp_stays.x64:	file format elf64-x86-64

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

<times5>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movl	0x8(%rsp), %ecx
               	movl	0xc(%rsp), %eax
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	movq	%rax, %rsi
               	shrq	$0x1e, %rsi
               	orq	%rdx, %rsi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rsi, %rcx
               	addq	%rdx, %rax
               	leaq	0x1(%rcx), %rsi
               	cmpl	%edx, %eax
               	cmovbq	%rsi, %rcx
               	movl	%ecx, %ecx
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<times9>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movl	0x8(%rsp), %ecx
               	movl	0xc(%rsp), %eax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	movq	%rax, %rsi
               	shrq	$0x1d, %rsi
               	orq	%rdx, %rsi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rsi, %rcx
               	addq	%rdx, %rax
               	leaq	0x1(%rcx), %rsi
               	cmpl	%edx, %eax
               	cmovbq	%rsi, %rcx
               	movl	%ecx, %ecx
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<step>:
               	subq	$0x20, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	leaq	0x28(%rsp), %rdi
               	movl	0x28(%rsp), %eax
               	movl	0x2c(%rsp), %ecx
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	movq	%rcx, %rsi
               	shrq	$0x19, %rsi
               	orq	%rsi, %rdx
               	shrq	$0x19, %rax
               	shlq	$0x7, %rcx
               	orq	%rcx, %rax
               	movl	%edx, 0x28(%rsp)
               	movl	%eax, 0x2c(%rsp)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movl	0x28(%rsp), %edi
               	movl	0x2c(%rsp), %r8d
               	movl	0x8(%rbx), %ecx
               	movl	0xc(%rbx), %eax
               	movq	%rcx, %rdx
               	shlq	$0x11, %rdx
               	movq	%rax, %rsi
               	shrq	$0xf, %rsi
               	movq	%rdx, %r9
               	orq	%rsi, %r9
               	movq	%rax, %r12
               	shlq	$0x11, %r12
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	0x10(%rbx), %r13d
               	xorq	%r13, %rdx
               	movl	%edx, 0x10(%rbx)
               	movl	0x14(%rbx), %r13d
               	xorq	%r13, %rsi
               	movl	%esi, 0x14(%rbx)
               	movl	0x18(%rbx), %r13d
               	xorq	%r13, %rcx
               	movl	%ecx, 0x18(%rbx)
               	movl	0x1c(%rbx), %r13d
               	xorq	%r13, %rax
               	movl	%eax, 0x1c(%rbx)
               	xorl	%edx, 0x8(%rbx)
               	xorl	%esi, 0xc(%rbx)
               	xorl	%ecx, (%rbx)
               	xorl	%eax, 0x4(%rbx)
               	xorl	%r9d, 0x10(%rbx)
               	xorl	%r12d, 0x14(%rbx)
               	movl	0x18(%rbx), %eax
               	movl	0x1c(%rbx), %ecx
               	movq	%rax, %rdx
               	shrq	$0x13, %rdx
               	movq	%rcx, %rsi
               	shlq	$0xd, %rsi
               	orq	%rsi, %rdx
               	shlq	$0xd, %rax
               	shrq	$0x13, %rcx
               	orq	%rcx, %rax
               	movl	%edx, 0x18(%rbx)
               	movl	%eax, 0x1c(%rbx)
               	movq	%r8, %rax
               	shlq	$0x20, %rax
               	orq	%rdi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq

<main>:
               	subq	$0x38, %rsp
               	movabsq	$0x3ef00000000, %rax    # imm = 0x3EF00000000
               	movq	%rax, 0x10(%rsp)
               	movabsq	$0xff00000000, %rax     # imm = 0xFF00000000
               	movq	%rax, 0x18(%rsp)
               	movq	$0x0, 0x20(%rsp)
               	leaq	0x10(%rsp), %rdi
               	movq	$0x0, 0x28(%rsp)
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	shlq	$0x1f, %rax
               	shlq	%rax
               	movl	0xc(%rsp), %ecx
               	orq	%rcx, %rax
               	movabsq	$0x7a7040a5a323c9d6, %r11 # imm = 0x7A7040A5A323C9D6
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x10(%rsp), %eax
               	shlq	$0x1f, %rax
               	shlq	%rax
               	movl	0x14(%rsp), %ecx
               	orq	%rcx, %rax
               	movabsq	$0xba18b516cb227f9, %r11 # imm = 0xBA18B516CB227F9
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	0x28(%rsp), %eax
               	shlq	$0x1f, %rax
               	shlq	%rax
               	movl	0x2c(%rsp), %ecx
               	orq	%rcx, %rax
               	movabsq	$0x194f95cf3210cb5a, %r11 # imm = 0x194F95CF3210CB5A
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
