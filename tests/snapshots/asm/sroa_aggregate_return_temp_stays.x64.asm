
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
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movq	%rdi, %rcx
               	shlq	$0x2, %rcx
               	movq	%rax, %rdx
               	shrq	$0x1e, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rdi, %rdx
               	addq	%rcx, %rax
               	leaq	0x1(%rdx), %rsi
               	cmpl	%ecx, %eax
               	cmovbq	%rsi, %rdx
               	movl	%edx, %ecx
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	retq

<times9>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movq	%rdi, %rcx
               	shlq	$0x3, %rcx
               	movq	%rax, %rdx
               	shrq	$0x1d, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rdi, %rdx
               	addq	%rcx, %rax
               	leaq	0x1(%rdx), %rsi
               	cmpl	%ecx, %eax
               	cmovbq	%rsi, %rdx
               	movl	%edx, %ecx
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	movq	%rcx, %rsi
               	shrq	$0x19, %rsi
               	orq	%rsi, %rdx
               	movl	%eax, %eax
               	shrq	$0x19, %rax
               	shlq	$0x7, %rcx
               	orq	%rcx, %rax
               	leaq	0x28(%rsp), %rdi
               	movl	%edx, 0x28(%rsp)
               	movl	%eax, 0x2c(%rsp)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	movl	0x8(%rbx), %edx
               	movl	0xc(%rbx), %ecx
               	movq	%rdx, %rsi
               	shlq	$0x11, %rsi
               	movq	%rcx, %rdi
               	shrq	$0xf, %rdi
               	movq	%rsi, %r9
               	orq	%rdi, %r9
               	movq	%rcx, %r12
               	shlq	$0x11, %r12
               	movl	(%rbx), %esi
               	movl	0x4(%rbx), %edi
               	movl	0x10(%rbx), %r13d
               	xorq	%r13, %rsi
               	movl	%esi, 0x10(%rbx)
               	movl	0x14(%rbx), %r13d
               	xorq	%r13, %rdi
               	movl	%edi, 0x14(%rbx)
               	movl	0x18(%rbx), %r13d
               	xorq	%r13, %rdx
               	movl	%edx, 0x18(%rbx)
               	movl	0x1c(%rbx), %r13d
               	xorq	%r13, %rcx
               	movl	%ecx, 0x1c(%rbx)
               	xorl	%esi, 0x8(%rbx)
               	xorl	%edi, 0xc(%rbx)
               	xorl	%edx, (%rbx)
               	xorl	%ecx, 0x4(%rbx)
               	xorl	%r9d, 0x10(%rbx)
               	xorl	%r12d, 0x14(%rbx)
               	movl	0x18(%rbx), %ecx
               	movl	0x1c(%rbx), %edx
               	movq	%rcx, %rsi
               	shrq	$0x13, %rsi
               	movq	%rdx, %rdi
               	shlq	$0xd, %rdi
               	orq	%rdi, %rsi
               	shlq	$0xd, %rcx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%esi, 0x18(%rbx)
               	movl	%ecx, 0x1c(%rbx)
               	movl	%eax, %eax
               	shlq	$0x20, %r8
               	orq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	movabsq	$0x3ef00000000, %rax    # imm = 0x3EF00000000
               	movq	%rax, (%rsp)
               	movabsq	$0xff00000000, %rax     # imm = 0xFF00000000
               	movq	%rax, 0x8(%rsp)
               	movq	$0x0, 0x10(%rsp)
               	leaq	(%rsp), %rdi
               	movq	$0x0, 0x18(%rsp)
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	movl	%eax, %eax
               	shlq	$0x1f, %rax
               	shlq	%rax
               	orq	%rcx, %rax
               	movabsq	$0x7a7040a5a323c9d6, %r11 # imm = 0x7A7040A5A323C9D6
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rsp), %eax
               	shlq	$0x1f, %rax
               	shlq	%rax
               	movl	0x4(%rsp), %ecx
               	orq	%rcx, %rax
               	movabsq	$0xba18b516cb227f9, %r11 # imm = 0xBA18B516CB227F9
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x18(%rsp), %eax
               	shlq	$0x1f, %rax
               	shlq	%rax
               	movl	0x1c(%rsp), %ecx
               	orq	%rcx, %rax
               	movabsq	$0x194f95cf3210cb5a, %r11 # imm = 0x194F95CF3210CB5A
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
