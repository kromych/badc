
rotate_32bit_words.x64:	file format elf64-x86-64

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

<ror2>:
               	rorl	$0x2, %edi
               	movq	%rdi, %rax
               	retq

<ror7>:
               	rorl	$0x7, %edi
               	movq	%rdi, %rax
               	retq

<rol13>:
               	rorl	$0x13, %edi
               	movq	%rdi, %rax
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
               	movl	%edi, %ecx
               	movq	%rcx, %rax
               	shrq	$0x3, %rax
               	shlq	$0x1e, %rcx
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

<quarter>:
               	movl	(%rdi), %eax
               	movl	0x4(%rdi), %ecx
               	addq	%rcx, %rax
               	movl	%eax, (%rdi)
               	movl	%eax, %ecx
               	movl	0xc(%rdi), %eax
               	xorq	%rcx, %rax
               	rorl	$0x10, %eax
               	movl	%eax, 0xc(%rdi)
               	movl	0x8(%rdi), %ecx
               	movl	%eax, %eax
               	addq	%rcx, %rax
               	movl	%eax, 0x8(%rdi)
               	movl	%eax, %ecx
               	movl	0x4(%rdi), %eax
               	xorq	%rcx, %rax
               	rorl	$0x14, %eax
               	movl	%eax, 0x4(%rdi)
               	retq

<main>:
               	subq	$0x38, %rsp
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
               	movl	$0x1, %edi
               	leaq	-0x2(%rcx), %rsi
               	andq	$0x1f, %rsi
               	shlxq	%rsi, %rdi, %rsi
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
               	movl	$0x1, %edi
               	leaq	-0x7(%rcx), %rsi
               	andq	$0x1f, %rsi
               	shlxq	%rsi, %rdi, %rsi
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
               	movl	$0x1, %edi
               	leaq	-0x13(%rcx), %rsi
               	andq	$0x1f, %rsi
               	shlxq	%rsi, %rdi, %rsi
               	orq	%rsi, %rdx
               	jmp	<addr>
               	cmpl	%edx, %eax
               	jne	<addr>
               	movl	$0x1, 0x30(%rsp)
               	jmp	<addr>
               	movl	0x30(%rsp), %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	0x30(%rsp), %edi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rbx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	andq	$0x1f, %rsi
               	shlxq	%rsi, %r8, %rsi
               	orq	%rsi, %rdx
               	jmp	<addr>
               	cmpl	%edx, %eax
               	jne	<addr>
               	movl	0x30(%rsp), %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x20, %edi
               	movl	0x30(%rsp), %ecx
               	subq	%rcx, %rdi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rbx, %rsi
               	nop
               	testb	$0x1, %sil
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	andq	$0x1f, %rsi
               	shlxq	%rsi, %r8, %rsi
               	orq	%rsi, %rdx
               	nop
               	jmp	<addr>
               	cmpl	%edx, %eax
               	jne	<addr>
               	movl	0x30(%rsp), %eax
               	incq	%rax
               	movl	%eax, 0x30(%rsp)
               	movl	0x30(%rsp), %eax
               	nopl	(%rax)
               	cmpl	$0x20, %eax
               	jb	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rbx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movl	$0x1, %edi
               	leaq	-0x2(%rcx), %rsi
               	andq	$0x1f, %rsi
               	shlxq	%rsi, %rdi, %rsi
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
               	nopw	(%rax,%rax)
               	cmpl	$0x7, %r12d
               	jb	<addr>
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movl	$0xbfe1c8ab, %ecx       # imm = 0xBFE1C8AB
               	shrxq	%rax, %rcx, %rcx
               	nopw	(%rax,%rax)
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x1, %edx
               	leaq	-0x10(%rax), %rcx
               	andq	$0x1f, %rcx
               	shlxq	%rcx, %rdx, %rcx
               	orq	%rcx, %rbx
               	jmp	<addr>
               	movl	$0x9e3779b9, %r8d       # imm = 0x9E3779B9
               	addq	%rbx, %r8
               	movl	$0xdeadbeef, %eax       # imm = 0xDEADBEEF
               	xorq	%r8, %rax
               	movl	%eax, %edx
               	xorl	%eax, %eax
               	movq	%rax, %r12
               	jmp	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x20, %eax
               	jge	<addr>
               	shrxq	%rax, %rdx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x1, %esi
               	leaq	-0x14(%rax), %rcx
               	andq	$0x1f, %rcx
               	shlxq	%rcx, %rsi, %rcx
               	orq	%rcx, %r12
               	jmp	<addr>
               	leaq	0x20(%rsp), %rdi
               	movq	%r8, 0x18(%rsp)
               	callq	<addr>
               	movq	0x18(%rsp), %r8
               	movl	0x20(%rsp), %eax
               	cmpl	$0x401e3754, %eax       # imm = 0x401E3754
               	jne	<addr>
               	movl	0x24(%rsp), %eax
               	cmpl	%r12d, %eax
               	jne	<addr>
               	movl	0x28(%rsp), %eax
               	cmpl	%r8d, %eax
               	jne	<addr>
               	movl	0x2c(%rsp), %eax
               	cmpl	%ebx, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movq	%rax, 0x38(%rsp)
               	movq	0x38(%rsp), %rdi
               	callq	<addr>
               	movq	0x38(%rsp), %rcx
               	shrq	$0x7, %rcx
               	movq	0x38(%rsp), %rdx
               	shlq	$0x19, %rdx
               	orq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movq	0x38(%rsp), %rdi
               	callq	<addr>
               	movq	0x38(%rsp), %rcx
               	movl	%ecx, %edi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	shrxq	%rcx, %rdi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movl	$0x1, %r8d
               	leaq	-0x7(%rcx), %rsi
               	andq	$0x1f, %rsi
               	shlxq	%rsi, %r8, %rsi
               	orq	%rsi, %rdx
               	jmp	<addr>
               	movl	%edx, %ecx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
