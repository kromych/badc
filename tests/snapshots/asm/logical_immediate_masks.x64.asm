
logical_immediate_masks.x64:	file format elf64-x86-64

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

<ref_and>:
               	subq	$0x18, %rsp
               	movq	%rsi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	andq	%rax, %rdi
               	movq	%rdi, %rax
               	addq	$0x18, %rsp
               	retq

<ref_or>:
               	subq	$0x18, %rsp
               	movq	%rsi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	orq	%rax, %rdi
               	movq	%rdi, %rax
               	addq	$0x18, %rsp
               	retq

<ref_xor>:
               	subq	$0x18, %rsp
               	movq	%rsi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	xorq	%rax, %rdi
               	movq	%rdi, %rax
               	addq	$0x18, %rsp
               	retq

<ref_and32>:
               	subq	$0x18, %rsp
               	movl	%esi, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	andq	%rax, %rdi
               	movq	%rdi, %rax
               	addq	$0x18, %rsp
               	retq

<ref_or32>:
               	subq	$0x18, %rsp
               	movl	%esi, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	orq	%rax, %rdi
               	movq	%rdi, %rax
               	addq	$0x18, %rsp
               	retq

<ref_xor32>:
               	subq	$0x18, %rsp
               	movl	%esi, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	xorq	%rax, %rdi
               	movq	%rdi, %rax
               	addq	$0x18, %rsp
               	retq

<and_e64>:
               	andq	$0xff, %rdi
               	movq	%rdi, %rax
               	retq

<or_e8>:
               	movabsq	$-0xf0f0f0f0f0f0f10, %rax # imm = 0xF0F0F0F0F0F0F0F0
               	orq	%rdi, %rax
               	retq

<xor_top>:
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	xorq	%rdi, %rax
               	retq

<and_align>:
               	andq	$-0x10, %rdi
               	movq	%rdi, %rax
               	retq

<or_wrap>:
               	movabsq	$-0xffffffffffff01, %rax # imm = 0xFF000000000000FF
               	orq	%rdi, %rax
               	retq

<xor_e2>:
               	movabsq	$0x5555555555555555, %rax # imm = 0x5555555555555555
               	xorq	%rdi, %rax
               	retq

<and_e4>:
               	movabsq	$0x7777777777777777, %rax # imm = 0x7777777777777777
               	andq	%rdi, %rax
               	retq

<and_e16>:
               	movabsq	$0xff00ff00ff00ff, %rax # imm = 0xFF00FF00FF00FF
               	andq	%rdi, %rax
               	retq

<or_e32>:
               	movabsq	$0xffff0000ffff, %rax   # imm = 0xFFFF0000FFFF
               	orq	%rdi, %rax
               	retq

<xor_run>:
               	movabsq	$0xffffff00000, %rax    # imm = 0xFFFFFF00000
               	xorq	%rdi, %rax
               	retq

<and32_e8>:
               	andq	$0xf0f0f0f, %rdi        # imm = 0xF0F0F0F
               	movq	%rdi, %rax
               	retq

<or32_top>:
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	orq	%rdi, %rax
               	retq

<xor32_e16>:
               	xorq	$0xff00ff, %rdi         # imm = 0xFF00FF
               	movq	%rdi, %rax
               	retq

<and32_neg>:
               	andq	$-0x100, %rdi
               	movq	%rdi, %rax
               	retq

<xor32_e2>:
               	xorq	$0x55555555, %rdi       # imm = 0x55555555
               	movq	%rdi, %rax
               	retq

<or32_e4>:
               	orq	$0x33333333, %rdi       # imm = 0x33333333
               	movq	%rdi, %rax
               	retq

<and_plain>:
               	andq	$0x1234, %rdi           # imm = 0x1234
               	movq	%rdi, %rax
               	retq

<or_plain>:
               	orq	$0x12345678, %rdi       # imm = 0x12345678
               	movq	%rdi, %rax
               	retq

<xor_plain>:
               	xorq	$0x5, %rdi
               	movq	%rdi, %rax
               	retq

<mix_loop>:
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	movabsq	$-0xff00ff00ff0100, %r8 # imm = 0xFF00FF00FF00FF00
               	cmpl	%esi, %ecx
               	jge	<addr>
               	rorq	$0x39, %rax
               	movq	(%rdi,%rcx,8), %rdx
               	movq	%rdx, %r9
               	andq	%r8, %r9
               	xorq	%r9, %rax
               	orq	$0x10, %rax
               	andq	$0x1234, %rdx           # imm = 0x1234
               	xorq	%rdx, %rax
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jl	<addr>
               	retq

<classify>:
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	testb	$0x40, %dil
               	cmovneq	%rcx, %rax
               	movq	%rdi, %rcx
               	andq	$0xf0, %rcx
               	movq	%rax, %rdx
               	orq	$0x2, %rdx
               	cmpl	$0x30, %ecx
               	cmoveq	%rdx, %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	andq	%rdi, %rcx
               	movq	%rax, %rdx
               	orq	$0x4, %rdx
               	testq	%rcx, %rcx
               	cmoveq	%rdx, %rax
               	movq	%rax, %rcx
               	orq	$0x8, %rcx
               	testl	$0xf0f0f0f, %edi        # imm = 0xF0F0F0F
               	cmovneq	%rcx, %rax
               	retq

<update>:
               	movq	%rsi, %rcx
               	andq	$0x1f, %rcx
               	movl	(%rdi), %eax
               	andq	$-0xf9, %rax
               	shlq	$0x3, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x10, %rcx
               	xorq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movabsq	$-0xffff0001, %r11      # imm = 0xFFFFFFFF0000FFFF
               	andq	%r11, %rax
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movl	%eax, (%rdi)
               	movq	%rax, %rdx
               	andq	$0x7, %rdx
               	movq	%rax, %rcx
               	sarq	$0x3, %rcx
               	andq	$0x1f, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	addq	%rdx, %rcx
               	sarq	$0x10, %rax
               	addq	%rcx, %rax
               	retq

<main>:
               	subq	$0x60, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%r12,8), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movl	$0xff, %esi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movabsq	$-0xf0f0f0f0f0f0f10, %rsi # imm = 0xF0F0F0F0F0F0F0F0
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	callq	<addr>
               	nopl	(%rax,%rax)
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	$-0x10, %rsi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movabsq	$-0xffffffffffff01, %rsi # imm = 0xFF000000000000FF
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movabsq	$0x5555555555555555, %rsi # imm = 0x5555555555555555
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movabsq	$0x7777777777777777, %rsi # imm = 0x7777777777777777
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movabsq	$0xff00ff00ff00ff, %rsi # imm = 0xFF00FF00FF00FF
               	callq	<addr>
               	nopl	(%rax,%rax)
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movabsq	$0xffff0000ffff, %rsi   # imm = 0xFFFF0000FFFF
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movabsq	$0xffffff00000, %rsi    # imm = 0xFFFFFF00000
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movl	$0xf0f0f0f, %esi        # imm = 0xF0F0F0F
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movl	$0x80000000, %esi       # imm = 0x80000000
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movl	$0xff00ff, %esi         # imm = 0xFF00FF
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movl	$0xffffff00, %esi       # imm = 0xFFFFFF00
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movl	$0x55555555, %esi       # imm = 0x55555555
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movl	$0x33333333, %esi       # imm = 0x33333333
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movl	$0x1234, %esi           # imm = 0x1234
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movl	$0x12345678, %esi       # imm = 0x12345678
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	$0x40, 0x50(%rsp)
               	movq	$0xf0, 0x58(%rsp)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, 0x60(%rsp)
               	movl	$0xf0f0f0f, 0x68(%rsp)  # imm = 0xF0F0F0F
               	xorl	%edx, %edx
               	movq	0x50(%rsp), %rcx
               	andq	%rbx, %rcx
               	movl	$0x1, %esi
               	testq	%rcx, %rcx
               	movq	%rdx, %rcx
               	cmovneq	%rsi, %rcx
               	movq	0x58(%rsp), %rdx
               	andq	%rbx, %rdx
               	movq	%rcx, %rsi
               	orq	$0x2, %rsi
               	cmpq	$0x30, %rdx
               	cmoveq	%rsi, %rcx
               	movq	0x60(%rsp), %rdx
               	andq	%rbx, %rdx
               	movq	%rcx, %rsi
               	orq	$0x4, %rsi
               	testq	%rdx, %rdx
               	cmoveq	%rsi, %rcx
               	movl	%ebx, %edx
               	movl	0x68(%rsp), %esi
               	andq	%rsi, %rdx
               	movq	%rcx, %rsi
               	orq	$0x8, %rsi
               	testq	%rdx, %rdx
               	cmovneq	%rsi, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	incq	%r12
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x8, %esi
               	callq	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movabsq	$-0xff00ff00ff0100, %rcx # imm = 0xFF00FF00FF00FF00
               	movq	%rcx, 0x38(%rsp)
               	movq	$0x10, 0x40(%rsp)
               	movq	$0x1234, 0x48(%rsp)     # imm = 0x1234
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	rorq	$0x39, %rcx
               	movq	(%r8,%rdx,8), %rsi
               	movq	0x38(%rsp), %rdi
               	andq	%rsi, %rdi
               	xorq	%rdi, %rcx
               	movq	0x40(%rsp), %rdi
               	orq	%rdi, %rcx
               	movq	0x48(%rsp), %rdi
               	andq	%rdi, %rsi
               	xorq	%rsi, %rcx
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	callq	<addr>
               	cmpq	$0xef, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	callq	<addr>
               	movabsq	$-0xe0c0a0806040201, %r11 # imm = 0xF1F3F5F7F9FBFDFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	callq	<addr>
               	movabsq	$-0x7edcba9876543211, %r11 # imm = 0x8123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x89abcdef, %edi       # imm = 0x89ABCDEF
               	callq	<addr>
               	cmpl	$0x90b0d0f, %eax        # imm = 0x90B0D0F
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	leaq	0x28(%rsp), %rdi
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rdi)
               	movl	$0x12345, 0x30(%rsp)    # imm = 0x12345
               	movl	0x30(%rsp), %esi
               	callq	<addr>
               	movl	0x28(%rsp), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7, %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movq	%rcx, %rdx
               	sarq	$0x3, %rdx
               	andq	$0x1f, %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movq	%rcx, %rdx
               	sarq	$0x8, %rdx
               	andq	$0xff, %rdx
               	cmpl	$0xc8, %edx
               	jne	<addr>
               	movq	%rcx, %rdx
               	sarq	$0x10, %rdx
               	cmpl	$0x9daa, %edx           # imm = 0x9DAA
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movq	%rcx, %rdx
               	andq	$0x7, %rdx
               	sarq	$0x3, %rcx
               	andq	$0x1f, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movl	0x28(%rsp), %ecx
               	movq	%rcx, %rdx
               	sarq	$0x8, %rdx
               	andq	$0xff, %rdx
               	addq	%rsi, %rdx
               	sarq	$0x10, %rcx
               	addq	%rdx, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x60, %rsp
               	retq
