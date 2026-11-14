
xsi_interfaces_reach_the_c_library.x64:	file format elf64-x86-64

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

<visit>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdx, 0x18(%rsp)
               	movq	%rcx, %rbx
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movslq	(%rbx), %rax
               	testl	%eax, %eax
               	jle	<addr>
               	leaq	(%rdi,%rax), %rcx
               	cmpl	$0x0, 0x4(%rbx)
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	0x18(%rsp), %rcx
               	cmpl	$0x5, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	0x4(%rbx), %ecx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x2f, %esi
               	movq	%rcx, 0x10(%rsp)
               	callq	<addr>
               	movq	0x10(%rsp), %rcx
               	leaq	0x1(%rax), %rsi
               	jmp	<addr>

<files>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1c0, %rsp            # imm = 0x1C0
               	leaq	-0x1b0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x190(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	-0x190(%rbp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	movl	$0x60, %esi
               	leaq	<rip>, %rdx
               	leaq	-0x190(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movl	$0x60, %esi
               	leaq	<rip>, %rdx
               	leaq	-0x190(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x150(%rbp), %rdi
               	movl	$0x1180, %esi           # imm = 0x1180
               	xorl	%edx, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x64, %rdi
               	leaq	-0xf0(%rbp), %rsi
               	movl	$0x1180, %edx           # imm = 0x1180
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x90(%rbp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x78(%rbp), %eax
               	andq	$0xf000, %rax           # imm = 0xF000
               	cmpl	$0x1000, %eax           # imm = 0x1000
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x1b0(%rbp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x90(%rbp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x190(%rbp), %rdi
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	-0x1b0(%rbp), %rsi
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0xf0(%rbp), %rdi
               	callq	<addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	-0x190(%rbp), %rdi
               	leaq	-<rip>, %rsi # <addr>
               	movl	$0x4, %edx
               	movl	$0x9, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x190(%rbp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rcx), %r10
               	movw	%r10w, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rcx), %r10
               	movw	%r10w, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movzwq	0xc(%rcx), %r10
               	movw	%r10w, 0xc(%rax)
               	xorps	%xmm0, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorps	%xmm0, %xmm0
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %edi
               	movapd	%xmm1, %xmm0
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x0, (%rax)
               	movb	$0x0, 0x4(%rax)
               	leaq	<rip>, %rsi
               	movl	$0x2c, %edx
               	movl	$0x8, %ecx
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	leaq	0x3(%rdi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xa, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1e, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	jmp	<addr>
               	movl	$0xc, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	movl	$0xc, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x22, %edx
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rcx, %rax
               	jmp	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	callq	<addr>
               	xorl	%edi, %edi
               	movl	%edi, (%rax)
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$-0x14, %ecx
               	jl	<addr>
               	cmpl	$0x14, %ecx
               	jg	<addr>
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	callq	<addr>
               	callq	<addr>
               	leaq	-0x28(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x28(%rbp), %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x19, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movl	-0x28(%rbp), %edi
               	callq	<addr>
               	movl	-0x24(%rbp), %edi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	subsd	%xmm1, %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm1, %xmm0
               	ja	<addr>
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	addsd	%xmm1, %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm1, %xmm0
               	ja	<addr>
               	movl	$0x2, %edi
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	addsd	%xmm1, %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x40, %rax
               	jne	<addr>
               	movl	$0x40, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movapd	%xmm0, %xmm1
               	xorps	%xmm0, %xmm0
               	comisd	%xmm1, %xmm0
               	ja	<addr>
               	movsd	<rip>, %xmm0
               	comisd	%xmm0, %xmm1
               	jae	<addr>
               	movsd	%xmm1, 0x10(%rsp)
               	callq	<addr>
               	movsd	0x10(%rsp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	movl	$0x7, %edi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x40, %edx
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	callq	<addr>
               	leaq	-0x60(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
