
signaling_nan_float_copy_keeps_its_bits.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0x7f800001, -0x20(%rbp) # imm = 0x7F800001
               	movl	$0x3d, %edi
               	callq	<addr>
               	movss	-0x20(%rbp), %xmm0
               	movss	%xmm0, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x7f800001, %ecx       # imm = 0x7F800001
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x7ff8000020000000, %r11 # imm = 0x7FF8000020000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x3d, %edi
               	callq	<addr>
               	movss	-0x20(%rbp), %xmm0
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	cmpl	$0x7fc00001, %eax       # imm = 0x7FC00001
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
