
in6_address_predicates.x64:	file format elf64-x86-64

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

<in6>:
               	andq	$0xff, %rdi
               	andq	$0xff, %rsi
               	shlq	$0x8, %rsi
               	orq	%rsi, %rdi
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	andq	$0xff, %rcx
               	shlq	$0x18, %rcx
               	orq	%rcx, %rdx
               	shlq	$0x38, %r8
               	orq	%r8, %rdx
               	movq	%rdi, %rax
               	retq

<main>:
               	subq	$0x128, %rsp            # imm = 0x128
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	%rdx, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x110(%rsp)
               	xorl	%edi, %edi
               	movl	$0x1, %r8d
               	movq	%rax, 0x118(%rsp)
               	movq	%rdx, 0xa0(%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	%rdx, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x108(%rsp)
               	movl	$0xfe, %edi
               	movl	$0x80, %esi
               	xorl	%ecx, %ecx
               	movl	$0x1, %r8d
               	movq	%rax, 0xe8(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	movq	%rcx, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	%rdx, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x90(%rsp)
               	movl	$0xfe, %edi
               	movl	$0xc0, %esi
               	xorl	%ecx, %ecx
               	movl	$0x1, %r8d
               	movq	%rax, 0x100(%rsp)
               	movq	%rdx, 0x88(%rsp)
               	movq	%rcx, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	%rdx, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x78(%rsp)
               	xorl	%edi, %edi
               	movl	$0xff, %ecx
               	movl	$0x1, %r8d
               	movq	%rax, 0xf8(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rdi, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rdx, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%rdx, %rcx
               	shrq	$0x8, %rcx
               	movq	%rcx, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rdx, %rcx
               	shrq	$0x10, %rcx
               	movq	%rcx, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x50(%rsp)
               	shrq	$0x18, %rdx
               	movq	%rdx, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x48(%rsp)
               	xorl	%edi, %edi
               	movl	$0x2, %r8d
               	movq	%rax, 0x40(%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rdx, %r10
               	shrq	$0x20, %r10
               	movq	%r10, 0x30(%rsp)
               	movl	$0xff, %edi
               	movl	$0x1, %esi
               	xorl	%ecx, %ecx
               	movq	%rax, 0x28(%rsp)
               	movq	%rdx, 0x20(%rsp)
               	movq	%rcx, %rdx
               	movq	%rsi, %r8
               	callq	<addr>
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x18(%rsp)
               	shrq	$0x8, %rax
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xd0(%rsp)
               	movl	$0xff, %edi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x10(%rsp)
               	shrq	$0x8, %rax
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xc8(%rsp)
               	movl	$0xff, %edi
               	movl	$0x5, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xc0(%rsp)
               	shrq	$0x8, %rax
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xb8(%rsp)
               	movl	$0xff, %edi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xb0(%rsp)
               	shrq	$0x8, %rax
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0xa8(%rsp)
               	movl	$0xff, %edi
               	movl	$0xe, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shrq	$0x8, %rax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	cmpl	$0x0, 0x118(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0xf0(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0xa0(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x110(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0xe8(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0xe0(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0xd8(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x108(%rsp)
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	cmpl	$0x0, 0xe8(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0xe0(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0xd8(%rsp)
               	jne	<addr>
               	movq	0x108(%rsp), %rax
               	testb	$-0x1, %al
               	jne	<addr>
               	movq	%rax, %rsi
               	shrq	$0x8, %rsi
               	testb	$-0x1, %sil
               	jne	<addr>
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	testb	$-0x1, %sil
               	jne	<addr>
               	shrq	$0x18, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	0x110(%rsp), %rax
               	testb	$-0x1, %al
               	jne	<addr>
               	movq	0x110(%rsp), %rax
               	movq	%rax, %rsi
               	shrq	$0x8, %rsi
               	testb	$-0x1, %sil
               	jne	<addr>
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	testb	$-0x1, %sil
               	jne	<addr>
               	shrq	$0x18, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	movq	0x100(%rsp), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	cmpl	$0xfe, %esi
               	jne	<addr>
               	movl	%eax, %eax
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	andq	$0xc0, %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movq	0xf8(%rsp), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	cmpl	$0xfe, %esi
               	jne	<addr>
               	movl	%eax, %eax
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	andq	$0xc0, %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	movq	0xf8(%rsp), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	cmpl	$0xfe, %esi
               	jne	<addr>
               	movl	%eax, %eax
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	andq	$0xc0, %rax
               	cmpl	$0xc0, %eax
               	jne	<addr>
               	movq	0x100(%rsp), %rax
               	movl	%eax, %eax
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	andq	$0xc0, %rax
               	cmpl	$0xc0, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	cmpl	$0x0, 0x40(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x68(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x60(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x58(%rsp)
               	jne	<addr>
               	movq	0x50(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	cmpl	$0x0, 0x28(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x38(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x20(%rsp)
               	jne	<addr>
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, (%rsp)
               	movq	0x30(%rsp), %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	movq	0x8(%rsp), %rcx
               	movq	(%rsp), %rdx
               	cmpq	$0x1, %rax
               	jbe	<addr>
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, (%rsp)
               	movq	0x108(%rsp), %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	movq	0x8(%rsp), %rcx
               	movq	(%rsp), %rdx
               	cmpq	$0x1, %rax
               	jbe	<addr>
               	movl	$0x6, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	movq	0x10(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0xd0(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	0xc8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	movq	0xc8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	0xc0(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0xb8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	movq	0xc0(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0xb8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	0xb0(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0xa8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	$0xa, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	movq	0xb0(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0xa8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xf, %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movl	$0xb, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	andq	$0xf, %rdx
               	cmpl	$0xe, %edx
               	jne	<addr>
               	movq	0xd0(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movl	$0xc, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	movq	0x100(%rsp), %rax
               	cmpl	0xf8(%rsp), %eax
               	jne	<addr>
               	movq	0x98(%rsp), %rax
               	cmpl	0x80(%rsp), %eax
               	jne	<addr>
               	movq	0x88(%rsp), %rax
               	cmpl	0x70(%rsp), %eax
               	jne	<addr>
               	movq	0x90(%rsp), %rax
               	cmpl	0x78(%rsp), %eax
               	jne	<addr>
               	movl	$0xd, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	xorl	%eax, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	movl	$0x7, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	movl	$0x5, %eax
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
