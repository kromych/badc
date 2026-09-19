
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
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movsbq	(%rcx), %rdx
               	movsbq	(%rax), %rsi
               	cmpl	%esi, %edx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%edx, %edx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rcx), %rsi
               	movsbq	0x4(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x8(%rcx), %rsi
               	movsbq	0x8(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rcx), %rsi
               	movslq	0xc(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x10(%rcx), %rcx
               	movsbq	0x10(%rax), %rsi
               	cmpl	%esi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rsi
               	movsbq	(%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movsbq	0x4(%rcx), %rdx
               	movsbq	0x4(%rax), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%esi, %esi
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x8(%rcx), %rdx
               	movsbq	0x8(%rax), %rdi
               	cmpl	%edi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0xc(%rcx), %rdx
               	movslq	0xc(%rax), %rdi
               	cmpl	%edi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x10(%rcx), %rcx
               	movsbq	0x10(%rax), %rdx
               	cmpl	%edx, %ecx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rsi
               	movslq	(%rdx), %rdi
               	cmpl	%edi, %esi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%esi, %esi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0x4(%rcx), %rdi
               	movslq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0x8(%rcx), %rdi
               	movslq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0xc(%rcx), %rdi
               	movslq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0x10(%rcx), %rsi
               	movslq	0x10(%rdx), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%edi, %edi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x14(%rcx), %rcx
               	movslq	0x14(%rdx), %rdx
               	cmpl	%edx, %ecx
               	sete	%dil
               	movzbq	%dil, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rsi
               	movslq	(%rdx), %rdi
               	cmpl	%edi, %esi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%esi, %esi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0x4(%rcx), %rdi
               	movslq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0x8(%rcx), %rdi
               	movslq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0xc(%rcx), %rdi
               	movslq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0x10(%rcx), %rsi
               	movslq	0x10(%rdx), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%edi, %edi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x14(%rcx), %rcx
               	movslq	0x14(%rdx), %rdx
               	cmpl	%edx, %ecx
               	sete	%dil
               	movzbq	%dil, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	movzbq	0x8(%rcx), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movzbq	0x9(%rcx), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movzbq	0xa(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
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
               	movsbq	0x4(%rax), %rdx
               	cmpl	$0x2, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x8(%rax), %rcx
               	cmpl	$0x3, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%edx, %edx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x4, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x10(%rax), %rcx
               	cmpl	$0x5, %ecx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rdx
               	movsbq	(%rax), %rsi
               	cmpl	%esi, %edx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%edx, %edx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rcx), %rsi
               	movsbq	0x4(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x8(%rcx), %rsi
               	movsbq	0x8(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rcx), %rsi
               	movslq	0xc(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x10(%rcx), %rcx
               	movsbq	0x10(%rax), %rax
               	cmpl	%eax, %ecx
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
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdi
               	jmp	<addr>
               	movq	%rsi, %rdi
               	jmp	<addr>
               	movq	%rsi, %rdi
               	jmp	<addr>
               	movq	%rsi, %rdi
               	jmp	<addr>
               	movq	%rsi, %rdi
               	jmp	<addr>
               	movq	%rsi, %rdi
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
