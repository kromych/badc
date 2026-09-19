
anon_member_inner_brace.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movsbq	(%rdx), %rcx
               	movsbq	(%rax), %rsi
               	cmpl	%esi, %ecx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%ecx, %ecx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rdx), %rsi
               	movsbq	0x4(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x8(%rdx), %rsi
               	movsbq	0x8(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rdx), %rsi
               	movslq	0xc(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x10(%rdx), %rcx
               	movsbq	0x10(%rax), %rdx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	movsbq	(%rdx), %rcx
               	movsbq	(%rax), %rsi
               	cmpl	%esi, %ecx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%ecx, %ecx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rdx), %rsi
               	movsbq	0x4(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x8(%rdx), %rsi
               	movsbq	0x8(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rdx), %rsi
               	movslq	0xc(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x10(%rdx), %rdx
               	movsbq	0x10(%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rdx), %rsi
               	movslq	(%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movslq	0x4(%rdx), %rcx
               	movslq	0x4(%rax), %rsi
               	cmpl	%esi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x8(%rdx), %rcx
               	movslq	0x8(%rax), %rdi
               	cmpl	%edi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0xc(%rdx), %rcx
               	movslq	0xc(%rax), %rdi
               	cmpl	%edi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x10(%rdx), %rcx
               	movslq	0x10(%rax), %rdi
               	cmpl	%edi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x14(%rdx), %rcx
               	movslq	0x14(%rax), %rdx
               	cmpl	%edx, %ecx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rcx
               	movslq	(%rax), %rsi
               	cmpl	%esi, %ecx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%ecx, %ecx
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x4(%rdx), %rsi
               	movslq	0x4(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x8(%rdx), %rsi
               	movslq	0x8(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rdx), %rsi
               	movslq	0xc(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x10(%rdx), %rsi
               	movslq	0x10(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x14(%rdx), %rcx
               	movslq	0x14(%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movzbq	0x8(%rax), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0xa(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x4(%rax), %rdx
               	cmpl	$0x2, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x8(%rax), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0xc(%rax), %rdx
               	cmpl	$0x4, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x10(%rax), %rdx
               	cmpl	$0x5, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	movsbq	(%rax), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%edx, %edx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x8(%rax), %rcx
               	cmpl	$0x3, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x4, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%edx, %edx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rax), %rsi
               	movsbq	0x4(%rcx), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x8(%rax), %rsi
               	movsbq	0x8(%rcx), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rax), %rsi
               	movslq	0xc(%rcx), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x10(%rax), %rax
               	movsbq	0x10(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	%rdx, %rax
               	retq
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
