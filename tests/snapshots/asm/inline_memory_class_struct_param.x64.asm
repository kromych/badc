
inline_memory_class_struct_param.x64:	file format elf64-x86-64

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

<weigh>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	-0x20(%rbp), %rax
               	imulq	%rdi, %rax
               	leave
               	retq

<use_sum>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	movq	0x10(%rdi), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rdi), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rdi), %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	retq

<use_forward>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movl	$0x7, %eax
               	movq	(%rdi), %rbx
               	movq	0x8(%rdi), %rcx
               	movq	0x10(%rdi), %rdx
               	movq	0x18(%rdi), %rsi
               	movq	0x20(%rdi), %rdi
               	leaq	-0x28(%rbp), %r9
               	movq	%rbx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	subq	$0x30, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	%rax, %rdi
               	callq	<addr>
               	addq	$0x30, %rsp
               	addq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<use_clobber>:
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	movq	$0x63, <rip> # <addr>
               	movq	$0x4d, <rip> # <addr>
               	imulq	$0x2710, %rax, %rax     # imm = 0x2710
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	imulq	$0x64, %rdx, %rcx
               	addq	%rcx, %rax
               	imulq	$0xa, %rsi, %rcx
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	retq

<use_pick>:
               	testl	%edx, %edx
               	je	<addr>
               	movq	0x10(%rdi), %rax
               	retq
               	movq	0x18(%rsi), %rax
               	jmp	<addr>

<use_find>:
               	movq	(%rdi), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x10(%rdi), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	0x20(%rdi), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x20(%rdi)
               	callq	<addr>
               	cmpq	$0x81, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rax
               	movq	-0x50(%rbp), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	-0x30(%rbp), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x20(%rcx)
               	callq	<addr>
               	cmpq	$0x3039, %rax           # imm = 0x3039
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x63, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x4d, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x20(%rsi)
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
