
numeric_conversions_follow_the_target_library.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movq	-0x8(%rbp), %rdx
               	leaq	<rip>, %rax
               	subq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	-0x8(%rbp), %rsi
               	movl	$0xa, %edx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, %r12
               	subq	%rcx, %r12
               	callq	<addr>
               	movl	(%rax), %ecx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	movq	%rsi, %rdx
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movl	(%rax), %edx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	movl	$0xa, %edx
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movl	(%rax), %edx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	movl	$0xa, %edx
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movl	(%rax), %edx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	movl	$0xa, %edx
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movl	(%rax), %edx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	movl	$0x24, %edx
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movl	(%rax), %edx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movq	%r13, %rcx
               	movq	%r12, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x25, %edx
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movl	(%rax), %edx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movapd	%xmm0, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movsd	%xmm0, 0x48(%rsp)
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movapd	%xmm0, %xmm1
               	movsd	0x48(%rsp), %xmm0
               	movb	$0x2, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	leaq	<rip>, %rdi
               	movapd	%xmm0, %xmm1
               	movsd	0x48(%rsp), %xmm0
               	movb	$0x2, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x30(%rbp), %r9
               	movsd	0x48(%rsp), %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x30(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x40(%rbp)
               	leaq	<rip>, %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x20, %rsp
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x48(%rsp)
               	callq	<addr>
               	movl	(%rax), %esi
               	leaq	<rip>, %rdi
               	movsd	0x48(%rsp), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x48(%rsp)
               	callq	<addr>
               	movl	(%rax), %esi
               	leaq	<rip>, %rdi
               	movsd	0x48(%rsp), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x48(%rsp)
               	callq	<addr>
               	movl	(%rax), %esi
               	leaq	<rip>, %rdi
               	movsd	0x48(%rsp), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movsd	%xmm0, 0x48(%rsp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x40(%rsp)
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movapd	%xmm0, %xmm2
               	movsd	0x48(%rsp), %xmm0
               	movsd	0x40(%rsp), %xmm1
               	movb	$0x3, %al
               	callq	<addr>
               	movl	$0x800, %edi            # imm = 0x800
               	callq	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movsd	%xmm0, 0x48(%rsp)
               	xorl	%edi, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movsd	0x48(%rsp), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x8(%rbp), %rsi
               	leaq	<rip>, %rax
               	subq	%rax, %rsi
               	movb	$0x1, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
