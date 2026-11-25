
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
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rcx,%rdi), %rsi
               	leaq	(%rdx,%rax), %rcx
               	leaq	0x1(%rsi), %rax
               	cmpl	%edx, %ecx
               	cmovaeq	%rsi, %rax
               	movl	%eax, %eax
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	retq

<times9>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movq	%rdi, %rcx
               	shlq	$0x3, %rcx
               	movq	%rax, %rdx
               	shrq	$0x1d, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rcx,%rdi), %rsi
               	leaq	(%rdx,%rax), %rcx
               	leaq	0x1(%rsi), %rax
               	cmpl	%edx, %ecx
               	cmovaeq	%rsi, %rax
               	movl	%eax, %eax
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	retq

<step>:
               	subq	$0x20, %rsp
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
               	leaq	0x18(%rsp), %rdi
               	movl	%edx, 0x18(%rsp)
               	movl	%eax, 0x1c(%rsp)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	shrq	$0x20, %r10
               	movl	0x8(%rbx), %r8d
               	movl	0xc(%rbx), %ecx
               	movq	%r8, %r9
               	shlq	$0x11, %r9
               	movq	%rcx, %rdx
               	shrq	$0xf, %rdx
               	orq	%rdx, %r9
               	movq	%rcx, %r11
               	shlq	$0x11, %r11
               	movl	(%rbx), %esi
               	movl	0x4(%rbx), %edi
               	movl	0x10(%rbx), %edx
               	xorq	%rsi, %rdx
               	movl	%edx, 0x10(%rbx)
               	movl	0x14(%rbx), %esi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x14(%rbx)
               	movl	0x18(%rbx), %edi
               	xorq	%r8, %rdi
               	movl	%edi, 0x18(%rbx)
               	movl	0x1c(%rbx), %r8d
               	xorq	%rcx, %r8
               	movl	%r8d, 0x1c(%rbx)
               	xorl	%edx, 0x8(%rbx)
               	xorl	%esi, 0xc(%rbx)
               	xorl	%edi, (%rbx)
               	xorl	%r8d, 0x4(%rbx)
               	xorl	%r9d, 0x10(%rbx)
               	xorl	%r11d, 0x14(%rbx)
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
               	shlq	$0x20, %r10
               	orq	%r10, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	movabsq	$0x3ef00000000, %rax    # imm = 0x3EF00000000
               	movq	%rax, (%rsp)
               	movabsq	$0xff00000000, %rax     # imm = 0xFF00000000
               	movq	%rax, 0x8(%rsp)
               	movq	$0x0, 0x10(%rsp)
               	movq	$0x0, 0x18(%rsp)
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
