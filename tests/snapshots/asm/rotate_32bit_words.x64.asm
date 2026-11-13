
rotate_32bit_words.x64:	file format elf64-x86-64

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

<ror2>:
               	movq	%rdi, %rax
               	rorl	$0x2, %eax
               	retq

<ror7>:
               	movq	%rdi, %rax
               	rorl	$0x7, %eax
               	retq

<rol13>:
               	movq	%rdi, %rax
               	rorl	$0x13, %eax
               	retq

<rotr_var>:
               	movl	%esi, %ecx
               	movq	%rdi, %rax
               	rorl	%cl, %eax
               	retq

<rotl_var>:
               	movq	%rsi, %rcx
               	negq	%rcx
               	movq	%rdi, %rax
               	rorl	%cl, %eax
               	retq

<widened>:
               	rorl	$0x2, %edi
               	leaq	0x1(%rdi), %rax
               	retq

<not_rot>:
               	movl	%edi, %eax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	shlq	$0x1e, %rax
               	orq	%rcx, %rax
               	retq

<arith>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	sarq	$0x2, %rax
               	shlq	$0x1e, %rdi
               	orq	%rdi, %rax
               	retq

<wide>:
               	movq	%rdi, %rax
               	shrq	$0x7, %rax
               	shlq	$0x19, %rdi
               	orq	%rdi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%r12,4), %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rbx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movl	$0x1, %esi
               	leaq	-0x2(%rcx), %rdi
               	andq	$0x1f, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rdx
               	jmp	<addr>
               	cmpl	%edx, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rbx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movl	$0x1, %esi
               	leaq	-0x7(%rcx), %rdi
               	andq	$0x1f, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rdx
               	jmp	<addr>
               	cmpl	%edx, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rbx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movl	$0x1, %esi
               	leaq	-0x13(%rcx), %rdi
               	andq	$0x1f, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rdx
               	jmp	<addr>
               	cmpl	%edx, %eax
               	jne	<addr>
               	movl	$0x1, -0x10(%rbp)
               	jmp	<addr>
               	movl	-0x10(%rbp), %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	-0x10(%rbp), %esi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rbx, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	andq	$0x1f, %r8
               	shlxq	%r8, %rdi, %rdi
               	orq	%rdi, %rdx
               	jmp	<addr>
               	cmpl	%edx, %eax
               	jne	<addr>
               	movl	-0x10(%rbp), %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x20, %esi
               	movl	-0x10(%rbp), %ecx
               	subq	%rcx, %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rbx, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	andq	$0x1f, %r8
               	shlxq	%r8, %rdi, %rdi
               	orq	%rdi, %rdx
               	jmp	<addr>
               	cmpl	%edx, %eax
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x20, %eax
               	jb	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rbx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movl	$0x1, %esi
               	leaq	-0x2(%rcx), %rdi
               	andq	$0x1f, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rdx
               	jmp	<addr>
               	movl	%edx, %ecx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shrq	$0x3, %rcx
               	movq	%rbx, %rdx
               	shlq	$0x1e, %rdx
               	orq	%rdx, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%ebx, %rcx
               	sarq	$0x2, %rcx
               	movq	%rbx, %rdx
               	shlq	$0x1e, %rdx
               	orq	%rdx, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	incq	%r12
               	cmpl	$0x7, %r12d
               	jb	<addr>
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	shrq	$0x7, %rcx
               	movq	-0x8(%rbp), %rdx
               	shlq	$0x19, %rdx
               	orq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	movl	%ecx, %esi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movl	$0x1, %edi
               	leaq	-0x7(%rcx), %r8
               	andq	$0x1f, %r8
               	shlxq	%r8, %rdi, %rdi
               	orq	%rdi, %rdx
               	jmp	<addr>
               	movl	%edx, %ecx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
