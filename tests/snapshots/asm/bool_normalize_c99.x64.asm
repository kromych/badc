
bool_normalize_c99.x64:	file format elf64-x86-64

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

<rti>:
               	subq	$0x18, %rsp
               	movl	%edi, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	addq	$0x18, %rsp
               	retq

<rtd>:
               	subq	$0x18, %rsp
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	0x8(%rsp), %xmm0
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	$0x5, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$-0x7, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x100, %edi            # imm = 0x100
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movapd	%xmm0, %xmm1
               	xorps	%xmm0, %xmm0
               	ucomisd	%xmm0, %xmm1
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testb	$-0x1, %al
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x63, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x8(%rsp)
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, (%rsp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	(%rsp), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x7b, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x8(%rsp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, (%rsp)
               	movq	$-0x3, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movq	0x8(%rsp), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpl	$0x0, (%rsp)
               	jne	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x11, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
