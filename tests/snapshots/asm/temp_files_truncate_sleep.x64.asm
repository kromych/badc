
temp_files_truncate_sleep.x64:	file format elf64-x86-64

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

<size_of>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x688, %rsp            # imm = 0x688
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rbx
               	leaq	-0x658(%rbp), %rdi
               	movl	$0x200, %esi            # imm = 0x200
               	leaq	<rip>, %rdx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x458(%rbp), %rdi
               	movl	$0x200, %esi            # imm = 0x200
               	leaq	<rip>, %rdx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x658(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jl	<addr>
               	leaq	-0x658(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x6, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x658(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x658(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x658(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x458(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x458(%rbp), %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	-0x458(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x458(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x668(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	-0x668(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	leaq	-0x668(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	-0x668(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0x678(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x7d0, %edi            # imm = 0x7D0
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0x668(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x668(%rbp), %rax
               	movq	-0x678(%rbp), %rcx
               	subq	%rcx, %rax
               	imulq	$0x3b9aca00, %rax, %rax # imm = 0x3B9ACA00
               	movq	-0x660(%rbp), %rcx
               	movq	-0x670(%rbp), %rdx
               	subq	%rdx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x1e8480, %rax         # imm = 0x1E8480
               	jge	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
