
word_index_addressing.x64:	file format elf64-x86-64

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

<get8s>:
               	movslq	%esi, %rsi
               	movsbq	(%rdi,%rsi), %rax
               	retq

<get8u>:
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rax
               	retq

<get16s>:
               	movslq	%esi, %rsi
               	movswq	(%rdi,%rsi,2), %rax
               	retq

<get16u>:
               	movslq	%esi, %rsi
               	movzwq	(%rdi,%rsi,2), %rax
               	retq

<get32s>:
               	movslq	%esi, %rsi
               	movslq	(%rdi,%rsi,4), %rax
               	retq

<get32u>:
               	movslq	%esi, %rsi
               	movl	(%rdi,%rsi,4), %eax
               	retq

<get64>:
               	movslq	%esi, %rsi
               	movq	(%rdi,%rsi,8), %rax
               	retq

<put8>:
               	movslq	%esi, %rsi
               	movq	$-0x38, %rax
               	movb	%al, (%rdi,%rsi)
               	retq

<put16>:
               	movslq	%esi, %rsi
               	movq	$-0x63c0, %rax          # imm = 0x9C40
               	movw	%ax, (%rdi,%rsi,2)
               	retq

<put32>:
               	movslq	%esi, %rsi
               	movq	$-0x5, %rax
               	movl	%eax, (%rdi,%rsi,4)
               	retq

<put64>:
               	movslq	%esi, %rsi
               	movq	$-0x6, %rax
               	movq	%rax, (%rdi,%rsi,8)
               	retq

<getu>:
               	movl	%esi, %eax
               	movslq	(%rdi,%rax,4), %rax
               	retq

<putu>:
               	movl	$0x21, %ecx
               	movl	%esi, %eax
               	movq	%rcx, (%rdi,%rax,8)
               	retq

<wrapped_int>:
               	leaq	(%rsi,%rdx), %rax
               	movslq	%eax, %rax
               	movslq	(%rdi,%rax,4), %rax
               	retq

<wrapped_unsigned>:
               	leaq	(%rsi,%rdx), %rax
               	movl	%eax, %eax
               	movq	(%rdi,%rax,8), %rax
               	retq

<index_and_value>:
               	leaq	(%rsi,%rdx), %rax
               	movslq	%eax, %rax
               	movslq	(%rdi,%rax,4), %rcx
               	addq	%rcx, %rax
               	retq

<swap>:
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movslq	(%rdi,%rsi,4), %rax
               	movslq	(%rdi,%rdx,4), %rcx
               	movl	%ecx, (%rdi,%rsi,4)
               	movl	%eax, (%rdi,%rdx,4)
               	retq

<sum_down>:
               	xorl	%ecx, %ecx
               	leaq	-0x1(%rsi), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	movslq	%eax, %rdx
               	movswq	(%rdi,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	retq

<sum_from>:
               	xorl	%eax, %eax
               	cmpl	%ecx, %edx
               	jae	<addr>
               	leaq	(%rsi,%rdx), %r8
               	movl	%r8d, %r8d
               	movzbq	(%rdi,%r8), %r8
               	addq	%r8, %rax
               	incq	%rdx
               	cmpl	%ecx, %edx
               	jb	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %r12
               	leaq	0x7(%r12), %rdi
               	leaq	<rip>, %rbx
               	movslq	(%rbx), %rax
               	leaq	-0x7(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x80, %rax
               	jne	<addr>
               	leaq	0x4(%r12), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x2(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movslq	(%rbx), %rax
               	leaq	0x7(%rax), %rsi
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x7f, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x7(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x1(%rax), %rsi
               	callq	<addr>
               	cmpq	$0xff, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x5(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x80, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0xe(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x7(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x8000, %rax          # imm = 0x8000
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x2(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0xe(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x1(%rax), %rsi
               	callq	<addr>
               	cmpq	$0xffff, %rax           # imm = 0xFFFF
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x5(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x8000, %rax           # imm = 0x8000
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x1c(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x7(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x2(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x1c(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x1(%rax), %rsi
               	callq	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x5(%rax), %rsi
               	callq	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x38(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x7(%rax), %rsi
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x40(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x2(%rax), %rsi
               	callq	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	0x8(%r12), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x8(%rax), %rsi
               	movl	$0xc8, %edx
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x8(%rax), %rsi
               	movl	$0x9c40, %edx           # imm = 0x9C40
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x8(%rax), %rsi
               	movq	$-0x5, %rdx
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	0x40(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x8(%rax), %rsi
               	movq	$-0x6, %rdx
               	callq	<addr>
               	movsbq	(%r12), %rax
               	cmpl	$-0x38, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpl	$0xffff9c40, %eax       # imm = 0xFFFF9C40
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$-0x6, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movsbq	0x1(%r12), %rax
               	cmpl	$-0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movswq	0x2(%rax), %rax
               	cmpl	$-0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$-0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	(%rbx), %rax
               	addq	$0x7, %rax
               	movl	%eax, %esi
               	callq	<addr>
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, %esi
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %r12
               	movslq	(%rbx), %rax
               	addq	$0x3, %rax
               	movl	%eax, %esi
               	movl	$0x21, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	0x18(%r12), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	0x7fffffff(%rax), %rsi
               	movslq	(%rbx), %rax
               	leaq	0x7fffffff(%rax), %rdx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x80000000(%rax), %rsi
               	movslq	(%rbx), %rax
               	leaq	-0x80000000(%rax), %rdx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	(%rbx), %rax
               	decq	%rax
               	movl	%eax, %esi
               	movslq	(%rbx), %rax
               	addq	$0x3, %rax
               	movl	%eax, %edx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	0x7fffffff(%rax), %rsi
               	movslq	(%rbx), %rax
               	leaq	0x7fffffff(%rax), %rdx
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	0x1(%rax), %rsi
               	movslq	(%rbx), %rax
               	leaq	0x2(%rax), %rdx
               	callq	<addr>
               	movl	$0x80000002, %r11d      # imm = 0x80000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %r12
               	leaq	0x10(%r12), %rdi
               	movslq	(%rbx), %rax
               	leaq	-0x3(%rax), %rsi
               	movslq	(%rbx), %rax
               	leaq	0x3(%rax), %rdx
               	callq	<addr>
               	movslq	0x4(%r12), %rax
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	0x2(%rax), %rdi
               	movslq	(%rbx), %rax
               	leaq	0x7(%rax), %rsi
               	callq	<addr>
               	cmpq	$0xfffd, %rax           # imm = 0xFFFD
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	(%rbx), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	(%rbx), %rax
               	addq	$-0x4, %rax
               	movl	%eax, %esi
               	movslq	(%rbx), %rax
               	addq	$0x4, %rax
               	movl	%eax, %edx
               	movslq	(%rbx), %rax
               	addq	$0x8, %rax
               	movl	%eax, %ecx
               	callq	<addr>
               	cmpq	$0x100, %rax            # imm = 0x100
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
