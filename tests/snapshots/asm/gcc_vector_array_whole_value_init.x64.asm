
gcc_vector_array_whole_value_init.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x4f0, %rsp            # imm = 0x4F0
               	leaq	-0x4f0(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x4e0(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x4d0(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x4c0(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movq	%rax, %rcx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	addq	$0x20, %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x4c0(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rax), %rcx
               	xorq	$0x10, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	0x10(%rax), %rcx
               	leaq	(%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x15, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rcx
               	xorq	$0x24, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	0x20(%rax), %rcx
               	leaq	(%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x29, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x38, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x490(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x4f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x4e0(%rbp), %rdx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rsi
               	leaq	-0x4d0(%rbp), %rsi
               	leaq	0x20(%rax), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rsi
               	leaq	(%rax), %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x1, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movzbq	0xf(%rax), %rsi
               	xorq	$0x10, %rsi
               	movl	%esi, %esi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	(%rcx), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x15, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x490(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	movzbq	0xf(%rcx), %rcx
               	xorq	$0x24, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	0x20(%rax), %rcx
               	leaq	(%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x29, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x38, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x460(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x4f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x4d0(%rbp), %rdx
               	leaq	0x20(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	(%rax), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x38, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	-0x400(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, (%rax)
               	movb	%cl, 0x1(%rax)
               	movb	%cl, 0x2(%rax)
               	movb	%cl, 0x3(%rax)
               	movb	%cl, 0x4(%rax)
               	leaq	-0x400(%rbp), %rax
               	movb	%cl, 0x5(%rax)
               	movb	%cl, 0x6(%rax)
               	movb	%cl, 0x7(%rax)
               	movb	%cl, 0x8(%rax)
               	movb	%cl, 0x9(%rax)
               	movb	%cl, 0xa(%rax)
               	movb	%cl, 0xb(%rax)
               	leaq	-0x400(%rbp), %rax
               	movb	%cl, 0xc(%rax)
               	movb	%cl, 0xd(%rax)
               	movb	%cl, 0xe(%rax)
               	movb	%cl, 0xf(%rax)
               	leaq	-0x4e0(%rbp), %rcx
               	leaq	0x10(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x7, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x400(%rbp), %rcx
               	leaq	0x10(%rcx), %rax
               	leaq	(%rax), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x15, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x24, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x3e0(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	movb	%cl, 0x1(%rax)
               	movb	%cl, 0x2(%rax)
               	movb	%cl, 0x3(%rax)
               	movb	%cl, 0x4(%rax)
               	movb	%cl, 0x5(%rax)
               	leaq	-0x3e0(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movb	%cl, 0x7(%rax)
               	movb	%cl, 0x8(%rax)
               	movb	%cl, 0x9(%rax)
               	movb	%cl, 0xa(%rax)
               	movb	%cl, 0xb(%rax)
               	movb	%cl, 0xc(%rax)
               	leaq	-0x3e0(%rbp), %rax
               	movb	%cl, 0xd(%rax)
               	movb	%cl, 0xe(%rax)
               	movb	%cl, 0xf(%rax)
               	leaq	-0x4f0(%rbp), %rdx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rsi
               	movzbq	0x7(%rax), %rsi
               	xorq	$0x3, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movzbq	0x7(%rcx), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x3c0(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	leaq	0x20(%rax), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	-0x4e0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movq	%rax, %rdx
               	leaq	(%rax), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x15, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	(%rsi), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x390(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x4d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	0x10(%rax), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rdx
               	leaq	0x20(%rax), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rsi
               	leaq	(%rax), %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x29, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movzbq	0x9(%rcx), %rcx
               	xorq	$0x32, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rdx), %rax
               	xorq	$0x38, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x360(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x4f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rdx
               	leaq	-0x4e0(%rbp), %rdx
               	leaq	0x10(%rax), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x4d0(%rbp), %rsi
               	leaq	0x20(%rax), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	leaq	0x30(%rax), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x360(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	addq	$0x0, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x15, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	0x20(%rax), %rcx
               	addq	$0x0, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x29, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	addq	$0x30, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x320(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	movq	%rcx, 0x40(%rax)
               	movq	%rcx, 0x48(%rax)
               	movq	%rcx, 0x50(%rax)
               	movq	%rcx, 0x58(%rax)
               	leaq	-0x4f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	0x10(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	0x20(%rax), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x4d0(%rbp), %rcx
               	addq	$0x30, %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x4e0(%rbp), %rcx
               	leaq	-0x320(%rbp), %rax
               	leaq	0x40(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x4f0(%rbp), %rdx
               	leaq	0x50(%rax), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rsi
               	leaq	(%rax), %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x1, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x20(%rax), %rsi
               	addq	$0x0, %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x29, %rsi
               	movl	%esi, %esi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	0x30(%rax), %rsi
               	addq	$0x0, %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x29, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	(%rcx), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	leaq	-0x2c0(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movq	%rax, %rcx
               	movl	$0x5, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x4e0(%rbp), %rcx
               	leaq	0x20(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movl	$0x6, %ecx
               	movl	%ecx, 0x30(%rax)
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x2c0(%rbp), %rax
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x5, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	addq	$0x20, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x24, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	addq	$0x10, %rcx
               	addq	$0x0, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x9, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movzbq	0xf(%rcx), %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
               	movl	$0x16, %eax
               	addq	$0x4f0, %rsp            # imm = 0x4F0
               	popq	%rbp
               	retq
