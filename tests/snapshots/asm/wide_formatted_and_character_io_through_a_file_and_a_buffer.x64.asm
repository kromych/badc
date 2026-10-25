
wide_formatted_and_character_io_through_a_file_and_a_buffer.x64:	file format elf64-x86-64

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

<vformat>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc0(%rbp), %rcx
               	movl	$0x18, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	movq	-0xc0(%rbp), %rdx
               	leaq	-0x18(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<vscan>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<vfile_print>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<vfile_scan>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<buffers>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movl	$0x0, -0xb8(%rbp)
               	movl	$0x0, -0xb0(%rbp)
               	movq	$0x0, -0xa8(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x20, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x2a, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x7a, %r9d
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x3039, %ecx           # imm = 0x3039
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x7b, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x20, %esi
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	$-0x7, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-0xb8(%rbp), %rdx
               	leaq	-0xa0(%rbp), %rcx
               	leaq	-0xa8(%rbp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0x11, %eax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	-0xa8(%rbp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-0xb8(%rbp), %rdx
               	leaq	-0xb0(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	-0xb0(%rbp), %eax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<file>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%esi, %esi
               	movl	%esi, -0x70(%rbp)
               	movl	%esi, -0x68(%rbp)
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x7, %edx
               	leaq	<rip>, %rcx # <addr>
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x8, %edx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x78, %edi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x78, %rax
               	jne	<addr>
               	movl	$0x79, %edi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x79, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-0x70(%rbp), %rdx
               	leaq	-0x60(%rbp), %rcx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movl	-0x70(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-0x68(%rbp), %rdx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x68(%rbp), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x78, %rax
               	jne	<addr>
               	movl	$0x78, %edi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x78, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x10, %esi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<strings_and_conversions>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	leaq	-0xc0(%rbp), %rdi
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	movups	0x30(%rax), %xmm14
               	movups	%xmm14, 0x30(%rdi)
               	movq	$0x0, -0xc8(%rbp)
               	leaq	-0x80(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xc0(%rbp), %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	0xc(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x2c(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0xc8(%rbp), %rsi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$-0x218711a00, %r11     # imm = 0xFFFFFFFDE78EE600
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0xc8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	fstpt	-0xe0(%rbp)
               	fldt	-0xe0(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
