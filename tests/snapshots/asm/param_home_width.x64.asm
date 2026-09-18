
param_home_width.x64:	file format elf64-x86-64

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

<step_u8>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x1(%rcx), %rdi
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	retq

<step_u16>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	0x1(%rcx), %rdi
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq

<step_u32>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%edi, %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	movl	%ecx, %edi
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movl	%edi, %eax
               	retq

<step_i8>:
               	movsbq	%dil, %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movsbq	%dil, %rcx
               	leaq	-0x3(%rcx), %rdi
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movsbq	%dil, %rax
               	retq

<step_i16>:
               	movswq	%di, %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movswq	%di, %rcx
               	leaq	-0x3(%rcx), %rdi
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movswq	%di, %rax
               	retq

<step_i32>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	subq	$0x3, %rdi
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movslq	%edi, %rax
               	retq

<step_long>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	subq	$0x3, %rdi
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	retq

<flip>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	testl	%ecx, %ecx
               	sete	%dil
               	movzbq	%dil, %rdi
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	retq

<toggle>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%edi, %ecx
               	movq	%rcx, %rdi
               	xorq	$0x1, %rdi
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movl	%edi, %eax
               	retq

<widen_u32>:
               	movl	%edi, %eax
               	incq	%rax
               	retq

<widen_i32>:
               	movslq	%edi, %rdi
               	leaq	-0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movabsq	$-0x5a5a5a5a5a5a5b00, %rbx # imm = 0xA5A5A5A5A5A5A500
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x48(%rbp)
               	leaq	-<rip>, %rax      # <addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x20(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x18(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x8(%rbp)
               	movabsq	$-0x5a5a5a5a5a5a5af9, %rdi # imm = 0xA5A5A5A5A5A5A507
               	xorq	%rsi, %rsi
               	movq	-0x50(%rbp), %rax
               	callq	*%rax
               	andq	$0xff, %rax
               	xorq	$0x7, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x5a5a5a5a5a5a5af9, %rdi # imm = 0xA5A5A5A5A5A5A507
               	movl	$0x2, %esi
               	movq	-0x50(%rbp), %rax
               	callq	*%rax
               	andq	$0xff, %rax
               	xorq	$0x43, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a5a5a5a38, %rdi # imm = 0xA5A5A5A5A5A5A5C8
               	movl	$0x1, %esi
               	movq	-0x50(%rbp), %rax
               	callq	*%rax
               	andq	$0xff, %rax
               	cmpl	$0x59, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a5a5afff9, %rdi # imm = 0xA5A5A5A5A5A50007
               	xorq	%rsi, %rsi
               	movq	-0x48(%rbp), %rax
               	callq	*%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x7, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x5a5a5a5a5a5a15a0, %rdi # imm = 0xA5A5A5A5A5A5EA60
               	movl	$0x1, %esi
               	movq	-0x48(%rbp), %rax
               	callq	*%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xbf21, %eax           # imm = 0xBF21
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5afffffff9, %rdi # imm = 0xA5A5A5A500000007
               	xorq	%rsi, %rsi
               	movq	-0x40(%rbp), %rax
               	callq	*%rax
               	movl	%eax, %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movabsq	$-0x5a5a5a5afffffff9, %rdi # imm = 0xA5A5A5A500000007
               	movl	$0x2, %esi
               	movq	-0x40(%rbp), %rax
               	callq	*%rax
               	movl	%eax, %eax
               	cmpl	$0x43, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a00000010, %rdi # imm = 0xA5A5A5A5FFFFFFF0
               	movl	$0x1, %esi
               	movq	-0x40(%rbp), %rax
               	callq	*%rax
               	movl	%eax, %eax
               	movl	$0xffffffd1, %r11d      # imm = 0xFFFFFFD1
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a5a5a5a05, %rdi # imm = 0xA5A5A5A5A5A5A5FB
               	xorq	%rsi, %rsi
               	movq	-0x38(%rbp), %rax
               	callq	*%rax
               	movsbq	%al, %rax
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	movabsq	$-0x5a5a5a5a5a5a5a05, %rdi # imm = 0xA5A5A5A5A5A5A5FB
               	movl	$0x2, %esi
               	movq	-0x38(%rbp), %rax
               	callq	*%rax
               	movsbq	%al, %rax
               	cmpl	$-0xb, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a5a5a0005, %rdi # imm = 0xA5A5A5A5A5A5FFFB
               	xorq	%rsi, %rsi
               	movq	-0x30(%rbp), %rax
               	callq	*%rax
               	movswq	%ax, %rax
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	movabsq	$-0x5a5a5a5a5a5a0005, %rdi # imm = 0xA5A5A5A5A5A5FFFB
               	movl	$0x2, %esi
               	movq	-0x30(%rbp), %rax
               	callq	*%rax
               	movswq	%ax, %rax
               	cmpl	$-0xb, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a00000005, %rdi # imm = 0xA5A5A5A5FFFFFFFB
               	xorq	%rsi, %rsi
               	movq	-0x28(%rbp), %rax
               	callq	*%rax
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	movabsq	$-0x5a5a5a5a00000005, %rdi # imm = 0xA5A5A5A5FFFFFFFB
               	movl	$0x2, %esi
               	movq	-0x28(%rbp), %rax
               	callq	*%rax
               	cmpl	$-0xb, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5, %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$-0xb, %rax
               	jne	<addr>
               	movl	$0x40000000, %edi       # imm = 0x40000000
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x3ffffffd, %rax       # imm = 0x3FFFFFFD
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a5a5a5aff, %rdi # imm = 0xA5A5A5A5A5A5A501
               	xorq	%rsi, %rsi
               	movq	-0x20(%rbp), %rax
               	callq	*%rax
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movabsq	$-0x5a5a5a5a5a5a5aff, %rdi # imm = 0xA5A5A5A5A5A5A501
               	movl	$0x3, %esi
               	movq	-0x20(%rbp), %rax
               	callq	*%rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %esi
               	movq	-0x20(%rbp), %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5affffffff, %rdi # imm = 0xA5A5A5A500000001
               	xorq	%rsi, %rsi
               	movq	-0x18(%rbp), %rax
               	callq	*%rax
               	movl	%eax, %eax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x5a5a5a5affffffff, %rdi # imm = 0xA5A5A5A500000001
               	movl	$0x3, %esi
               	movq	-0x18(%rbp), %rax
               	callq	*%rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a00000010, %rdi # imm = 0xA5A5A5A5FFFFFFF0
               	movq	-0x10(%rbp), %rax
               	callq	*%rax
               	movl	$0xfffffff1, %r11d      # imm = 0xFFFFFFF1
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a00000005, %rdi # imm = 0xA5A5A5A5FFFFFFFB
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	cmpq	$-0x6, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
