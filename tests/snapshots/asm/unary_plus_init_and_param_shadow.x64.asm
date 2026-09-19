
unary_plus_init_and_param_shadow.x64:	file format elf64-x86-64

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

<f>:
               	movslq	%edi, %rax
               	retq

<main>:
               	leaq	<rip>, %rdx
               	movsd	(%rdx,%riz), %xmm0
               	movabsq	$0x3fe6666666666666, %rsi # imm = 0x3FE6666666666666
               	movq	%rsi, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	subsd	%xmm1, %xmm0
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	xorl	%ecx, %ecx
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%dil
               	movzbq	%dil, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	0x8(%rdx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	movsd	0x10(%rdx,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	xorl	%ecx, %ecx
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%sil
               	movzbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	movsd	0x18(%rdx,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	subsd	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movslq	0x4(%rax), %rdx
               	cmpl	$-0x3, %edx
               	jne	<addr>
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	%rcx, %rax
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rdi
               	jmp	<addr>
