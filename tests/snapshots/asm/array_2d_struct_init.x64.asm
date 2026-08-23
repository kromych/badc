
array_2d_struct_init.x64:	file format elf64-x86-64

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
               	movsd	(%rcx,%riz), %xmm0
               	movl	$0x1, %eax
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x18(%rcx,%riz), %xmm0
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsd	0x20(%rcx,%riz), %xmm0
               	movabsq	$0x4014000000000000, %rdx # imm = 0x4014000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsd	0x38(%rcx,%riz), %xmm0
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	retq
               	leaq	<rip>, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsd	0x78(%rcx,%riz), %xmm0
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsd	0x50(%rcx,%riz), %xmm0
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movabsq	$0x4022000000000000, %rcx # imm = 0x4022000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsd	0x38(%rax,%riz), %xmm0
               	movabsq	$0x4030000000000000, %rax # imm = 0x4030000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x4026000000000000, %rax # imm = 0x4026000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
