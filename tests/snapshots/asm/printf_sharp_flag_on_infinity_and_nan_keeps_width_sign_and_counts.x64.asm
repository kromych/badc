
printf_sharp_flag_on_infinity_and_nan_keeps_width_sign_and_counts.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x150, %rsp            # imm = 0x150
               	pushq	%rbx
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x4, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x4, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x4, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x4, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x4, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x4, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x4, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xb, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xb, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x4, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x4, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xb, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xb, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movss	<rip>, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	0x110(%rsp), %rax
               	leaq	0x1(%rax), %rbx
               	movsbq	0x110(%rsp), %rcx
               	cmpl	$0x2d, %ecx
               	cmovneq	%rax, %rbx
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x3(%rbx), %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x28, %eax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movss	<rip>, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	0x110(%rsp), %rax
               	leaq	0x1(%rax), %rbx
               	movsbq	0x110(%rsp), %rcx
               	cmpl	$0x2d, %ecx
               	cmovneq	%rax, %rbx
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x3(%rbx), %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x28, %eax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movss	<rip>, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	0x110(%rsp), %rax
               	leaq	0x1(%rax), %rbx
               	movsbq	0x110(%rsp), %rcx
               	cmpl	$0x2d, %ecx
               	cmovneq	%rax, %rbx
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x3(%rbx), %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x28, %eax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movss	<rip>, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	0x110(%rsp), %rax
               	leaq	0x1(%rax), %rbx
               	movsbq	0x110(%rsp), %rcx
               	cmpl	$0x2d, %ecx
               	cmovneq	%rax, %rbx
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x3(%rbx), %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x28, %eax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	leaq	0x10(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x19, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %rcx
               	leaq	<rip>, %rsi
               	leaq	0x10(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	leaq	0x10(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xd, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %rcx
               	leaq	<rip>, %rsi
               	leaq	0x10(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	leaq	0x10(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movl	$0x7, %ecx
               	leaq	<rip>, %r8
               	movb	$0x2, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x9, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %rcx
               	leaq	<rip>, %rsi
               	leaq	0x10(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	xorl	%edi, %edi
               	xorl	%esi, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, 0x148(%rsp)
               	movsd	<rip>, %xmm0
               	leaq	0x10(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	leaq	0x148(%rsp), %rcx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x5, %ebx
               	jne	<addr>
               	movl	0x148(%rsp), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movl	0x148(%rsp), %r8d
               	movq	%rbx, %rcx
               	leaq	<rip>, %rsi
               	leaq	0x10(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x6, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x110(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x110(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x50(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x50(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpl	%eax, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x50(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x50(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x50(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpl	%eax, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x50(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x50(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x50(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpl	%eax, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x50(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x50(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x50(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpl	%eax, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x50(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x50(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x50(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpl	%eax, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	0x50(%rsp), %rcx
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	leaq	0x50(%rsp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x50(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x7, %ebx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %rcx
               	leaq	<rip>, %rsi
               	leaq	0x50(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	popq	%rbx
               	addq	$0x150, %rsp            # imm = 0x150
               	retq
