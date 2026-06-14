
two_d_array_param_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x270, %esi            # imm = 0x270
               	callq	<addr>
               	ud2

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<sum_short_row>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movzwq	(%rax), %rcx
               	movzwq	0x2(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<sum_int_row>:
               	movslq	%esi, %rsi
               	imulq	$0xc, %rsi, %rax
               	addq	%rdi, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<sum_char_row>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movsbq	(%rax), %rcx
               	movsbq	0x1(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movsbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movsbq	0x3(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x4d0, %rsp            # imm = 0x4D0
               	movq	%rbx, (%rsp)
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rax
               	movslq	%ecx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	xorq	%rdx, %rdx
               	movw	%dx, (%rax)
               	leaq	-0x400(%rbp), %rax
               	movslq	%ecx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	movw	%dx, 0x2(%rax)
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0x14(%rax)
               	leaq	-0x400(%rbp), %rax
               	movl	$0x10, %ecx
               	movw	%cx, 0x16(%rax)
               	leaq	-0x400(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x1244, %rax           # imm = 0x1244
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x4d0, %rsp            # imm = 0x4D0
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpq	$0x837, %rax            # imm = 0x837
               	je	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rax
               	movslq	%ebx, %rdx
               	imulq	$0xc, %rdx, %rsi
               	addq	%rsi, %rax
               	movslq	%ecx, %rsi
               	imulq	$0x64, %rdx, %rdx
               	movslq	%edx, %rdx
               	addq	%rsi, %rdx
               	movl	%edx, (%rax,%rsi,4)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x4d0, %rsp            # imm = 0x4D0
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x116, %rax            # imm = 0x116
               	je	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rax
               	movslq	%ebx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	movslq	%ecx, %rsi
               	addq	%rsi, %rax
               	addq	$0x41, %rdx
               	movslq	%edx, %rdx
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x4d0, %rsp            # imm = 0x4D0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x4d0, %rsp            # imm = 0x4D0
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
