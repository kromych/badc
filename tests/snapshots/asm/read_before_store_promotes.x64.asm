
read_before_store_promotes.x64:	file format elf64-x86-64

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

<maybe>:
               	movslq	%edi, %rdi
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	testq	%rdi, %rdi
               	cmoveq	%rcx, %rax
               	retq

<self_init>:
               	movl	$0x5, %eax
               	retq

<fp_maybe>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, %xmm0
               	testq	%rdi, %rdi
               	je	<addr>
               	retq
               	movabsq	$0x4004000000000000, %r11 # imm = 0x4004000000000000
               	movq	%r11, %xmm0
               	jmp	<addr>

<f32_maybe>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x3e800000, %r11d      # imm = 0x3E800000
               	movq	%r11, %xmm0
               	testq	%rdi, %rdi
               	je	<addr>
               	retq
               	movl	$0x3f000000, %r11d      # imm = 0x3F000000
               	movq	%r11, %xmm0
               	jmp	<addr>

<narrow_maybe>:
               	movslq	%edi, %rdi
               	movq	$-0x3, %rax
               	movl	$0x7, %ecx
               	testq	%rdi, %rdi
               	cmoveq	%rcx, %rax
               	retq

<u8_maybe>:
               	movslq	%edi, %rdi
               	movl	$0xc8, %eax
               	movl	$0x9, %ecx
               	testq	%rdi, %rdi
               	cmoveq	%rcx, %rax
               	retq

<loop_first>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	addq	%rcx, %rdx
               	testl	%eax, %eax
               	cmovgq	%rdx, %rcx
               	movq	%rax, %rdx
               	shlq	%rdx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<probe>:
               	leaq	<rip>, %rcx # <addr>
               	movl	%edx, %eax
               	movzwq	(%rcx,%rax,2), %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x14, %eax
               	subq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%esi, %eax
               	ja	<addr>
               	andq	$0xf, %rdx
               	cmpl	$0x9, %edx
               	je	<addr>
               	movl	%edx, %eax
               	movzwq	(%rcx,%rax,2), %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	retq

<self_loop>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	(%rax,%rax,2), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	movq	%rcx, %rax
               	retq

<inlined>:
               	movslq	%edi, %rdi
               	xorl	%eax, %eax
               	imulq	$0xa, %rdi, %rcx
               	cmpl	$0x2, %edi
               	cmovgq	%rcx, %rax
               	movq	$-0x1, %rcx
               	cmpl	$0x2, %edi
               	cmovleq	%rcx, %rax
               	leaq	0x3(%rdi), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	retq

<stack_arg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x28(%rbp), %rax
               	decq	%rax
               	addq	$0x2, %rax
               	subq	$0x2, %rax
               	addq	$0x3, %rax
               	subq	$0x3, %rax
               	addq	$0x4, %rax
               	subq	$0x4, %rax
               	addq	$0x5, %rax
               	subq	$0x5, %rax
               	addq	$0x6, %rax
               	leaq	-0x6(%rax), %rcx
               	movq	0x10(%rbp), %rax
               	addq	%rax, %rcx
               	subq	%rax, %rcx
               	movq	0x18(%rbp), %rax
               	addq	%rax, %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movq	0x20(%rbp), %rcx
               	leaq	(%rdx,%rcx), %rax
               	subq	%rcx, %rax
               	popq	%rbp
               	retq

<make>:
               	movl	$0x28, %eax
               	retq

<field_of_result>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x14, %edi
               	callq	<addr>
               	incq	%rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movl	$0x3e800000, %eax       # imm = 0x3E800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xc8, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x14, %edi
               	movl	$0x1e, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movl	$0x14, %edi
               	movl	$0x5, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x14, %edi
               	movl	$0x1e, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x27, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	subq	$0x20, %rsp
               	movq	$0x7, (%rsp)
               	movq	$0x8, 0x8(%rsp)
               	movq	$0x9, 0x10(%rsp)
               	movq	$0x28, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x27, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
