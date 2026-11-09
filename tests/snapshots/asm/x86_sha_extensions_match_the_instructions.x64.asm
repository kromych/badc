
x86_sha_extensions_match_the_instructions.x64:	file format elf64-x86-64

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

<_mm_sha1rnds4_epu32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movups	%xmm0, -0x40(%rbp)
               	movups	%xmm1, -0x30(%rbp)
               	movl	-0x40(%rbp), %ecx
               	movl	-0x3c(%rbp), %edx
               	movl	-0x38(%rbp), %eax
               	movl	-0x34(%rbp), %r9d
               	movl	-0x30(%rbp), %r8d
               	movl	-0x2c(%rbp), %esi
               	movl	-0x28(%rbp), %ebx
               	movl	-0x24(%rbp), %r12d
               	leaq	-0x10(%rbp), %r13
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r13)
               	movl	%r12d, -0x10(%rbp)
               	movl	%ebx, -0xc(%rbp)
               	movl	%esi, -0x8(%rbp)
               	xorl	%esi, %esi
               	movl	%r8d, -0x4(%rbp)
               	movq	%rsi, %r12
               	movq	%rdi, %r8
               	andq	$0x3, %r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	cmpl	$0x2, %r8d
               	je	<addr>
               	movq	%rax, %r8
               	xorq	%rdx, %r8
               	xorq	%rcx, %r8
               	jmp	<addr>
               	movq	%rax, %r8
               	andq	%rdx, %r8
               	movq	%rax, %rbx
               	andq	%rcx, %rbx
               	xorq	%rbx, %r8
               	movq	%rdx, %rbx
               	andq	%rcx, %rbx
               	xorq	%rbx, %r8
               	jmp	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	%rax, %r8
               	andq	%rdx, %r8
               	movq	%rax, %rbx
               	xorq	$-0x1, %rbx
               	andq	%rcx, %rbx
               	xorq	%rbx, %r8
               	movl	%r9d, %ebx
               	movq	%rbx, %r13
               	shlq	$0x5, %r13
               	shrq	$0x1b, %rbx
               	orq	%r13, %rbx
               	addq	%rbx, %r8
               	leaq	-0x10(%rbp), %rbx
               	movl	(%rbx,%rsi,4), %ebx
               	addq	%rbx, %r8
               	addq	%r12, %r8
               	leaq	<rip>, %rbx # <addr>
               	movq	%rdi, %r12
               	andq	$0x3, %r12
               	movl	(%rbx,%r12,4), %ebx
               	addq	%rbx, %r8
               	movl	%eax, %eax
               	movq	%rax, %rbx
               	shlq	$0x1e, %rbx
               	shrq	$0x2, %rax
               	orq	%rbx, %rax
               	incq	%rsi
               	movq	%rcx, %r12
               	movq	%rdx, %rcx
               	movq	%rax, %rdx
               	movq	%r9, %rax
               	movq	%r8, %r9
               	cmpl	$0x4, %esi
               	jl	<addr>
               	leaq	-0x20(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x1c(%rbp)
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	%r9d, -0x14(%rbp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0xd3dcc5a2, -0x80(%rbp) # imm = 0xD3DCC5A2
               	movl	$0xa70480db, -0x7c(%rbp) # imm = 0xA70480DB
               	movl	$0xd665ca49, -0x78(%rbp) # imm = 0xD665CA49
               	movl	$0xdaa9b5f, -0x74(%rbp) # imm = 0xDAA9B5F
               	leaq	-0x70(%rbp), %rsi
               	movl	$0xc21fde95, -0x70(%rbp) # imm = 0xC21FDE95
               	movl	$0x3ead5c56, -0x6c(%rbp) # imm = 0x3EAD5C56
               	movl	$0xcd1d0205, -0x68(%rbp) # imm = 0xCD1D0205
               	movl	$0xaf5a022b, -0x64(%rbp) # imm = 0xAF5A022B
               	movl	-0x74(%rbp), %ecx
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movl	-0x44(%rbp), %edx
               	movq	%rcx, %rsi
               	shlq	$0x1e, %rsi
               	shrq	$0x2, %rcx
               	orq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movl	%ecx, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x40(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0xc21fde95, -0x40(%rbp) # imm = 0xC21FDE95
               	movl	$0x3ead5c56, -0x3c(%rbp) # imm = 0x3EAD5C56
               	leaq	-0x40(%rbp), %rdi
               	movl	$0xcd1d0205, -0x38(%rbp) # imm = 0xCD1D0205
               	movl	$0x72c4a902, -0x34(%rbp) # imm = 0x72C4A902
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	-0x80(%rbp), %eax
               	movl	-0x7c(%rbp), %ecx
               	movl	-0x78(%rbp), %edx
               	movl	-0x74(%rbp), %esi
               	movl	-0x68(%rbp), %edi
               	movl	-0x64(%rbp), %r8d
               	leaq	-0x50(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	xorq	%rax, %rdi
               	movl	%edi, -0x50(%rbp)
               	xorq	%rcx, %r8
               	movl	%r8d, -0x4c(%rbp)
               	xorq	%rdx, %rax
               	movl	%eax, -0x48(%rbp)
               	xorq	%rsi, %rcx
               	movl	%ecx, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x40(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0x1ec1c7a7, -0x40(%rbp) # imm = 0x1EC1C7A7
               	movl	$0x85e82f0, -0x3c(%rbp) # imm = 0x85E82F0
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x5b90feb, -0x38(%rbp) # imm = 0x5B90FEB
               	movl	$0xaaae1b84, -0x34(%rbp) # imm = 0xAAAE1B84
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	-0x80(%rbp), %edx
               	movl	-0x7c(%rbp), %esi
               	movl	-0x78(%rbp), %ecx
               	movl	-0x74(%rbp), %eax
               	movl	-0x70(%rbp), %edi
               	movl	-0x6c(%rbp), %r8d
               	movl	-0x68(%rbp), %r9d
               	xorq	%r9, %rax
               	movq	%rax, %r9
               	shlq	%r9
               	shrq	$0x1f, %rax
               	orq	%r9, %rax
               	xorq	%r8, %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x1f, %rcx
               	orq	%rcx, %r8
               	movq	%rsi, %rcx
               	xorq	%rdi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	shrq	$0x1f, %rcx
               	orq	%rcx, %rsi
               	xorq	%rax, %rdx
               	movl	%edx, %ecx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shrq	$0x1f, %rcx
               	orq	%rdx, %rcx
               	leaq	-0x50(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	%ecx, -0x50(%rbp)
               	movl	%esi, -0x4c(%rbp)
               	movl	%r8d, -0x48(%rbp)
               	movl	%eax, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x40(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0xa567ee2e, -0x40(%rbp) # imm = 0xA567EE2E
               	movl	$0xca36bc9c, -0x3c(%rbp) # imm = 0xCA36BC9C
               	leaq	-0x40(%rbp), %rsi
               	movl	$0xd1912c3f, -0x38(%rbp) # imm = 0xD1912C3F
               	movl	$0x816f32b5, -0x34(%rbp) # imm = 0x816F32B5
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x80(%rbp), %r9
               	leaq	-0x70(%rbp), %rax
               	xorl	%edi, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0x11b31b64, -0x40(%rbp) # imm = 0x11B31B64
               	movl	$0x9f258176, -0x3c(%rbp) # imm = 0x9F258176
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x464e48ab, -0x38(%rbp) # imm = 0x464E48AB
               	movl	$0xefff836d, -0x34(%rbp) # imm = 0xEFFF836D
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x80(%rbp), %r9
               	leaq	-0x70(%rbp), %rax
               	movl	$0x1, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0x5d913a37, -0x40(%rbp) # imm = 0x5D913A37
               	movl	$0x2dea0e03, -0x3c(%rbp) # imm = 0x2DEA0E03
               	leaq	-0x40(%rbp), %rsi
               	movl	$0xa4a0700, -0x38(%rbp) # imm = 0xA4A0700
               	movl	$0x1927c1b5, -0x34(%rbp) # imm = 0x1927C1B5
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x80(%rbp), %r9
               	leaq	-0x70(%rbp), %rax
               	movl	$0x2, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0xf2c37aec, -0x40(%rbp) # imm = 0xF2C37AEC
               	movl	$0xedd6e375, -0x3c(%rbp) # imm = 0xEDD6E375
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x23493796, -0x38(%rbp) # imm = 0x23493796
               	movl	$0x2347af9e, -0x34(%rbp) # imm = 0x2347AF9E
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x80(%rbp), %r9
               	leaq	-0x70(%rbp), %rax
               	movl	$0x3, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0xb4736fc4, -0x40(%rbp) # imm = 0xB4736FC4
               	movl	$0x6112f53b, -0x3c(%rbp) # imm = 0x6112F53B
               	leaq	-0x40(%rbp), %rsi
               	movl	$0xa0cda80e, -0x38(%rbp) # imm = 0xA0CDA80E
               	movl	$0xf2332cf, -0x34(%rbp) # imm = 0xF2332CF
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rax)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	-0x80(%rbp), %edx
               	movl	-0x7c(%rbp), %r9d
               	movl	-0x78(%rbp), %r12d
               	movl	-0x74(%rbp), %r8d
               	movl	-0x70(%rbp), %ebx
               	movl	-0x6c(%rbp), %ecx
               	movl	-0x68(%rbp), %edi
               	movl	-0x64(%rbp), %eax
               	movq	%rcx, %rsi
               	shrq	$0x6, %rsi
               	movq	%rcx, %r13
               	shlq	$0x1a, %r13
               	orq	%r13, %rsi
               	movq	%rcx, %r13
               	shrq	$0xb, %r13
               	movq	%rcx, %r14
               	shlq	$0x15, %r14
               	orq	%r14, %r13
               	xorq	%r13, %rsi
               	movq	%rcx, %r13
               	shrq	$0x19, %r13
               	movq	%rcx, %r14
               	shlq	$0x7, %r14
               	orq	%r14, %r13
               	xorq	%r13, %rsi
               	movq	%rax, %r13
               	shrq	$0x2, %r13
               	movq	%rax, %r14
               	shlq	$0x1e, %r14
               	orq	%r14, %r13
               	movq	%rax, %r14
               	shrq	$0xd, %r14
               	movq	%rax, %r15
               	shlq	$0x13, %r15
               	orq	%r15, %r14
               	xorq	%r14, %r13
               	movq	%rax, %r14
               	shrq	$0x16, %r14
               	movq	%rax, %r15
               	shlq	$0xa, %r15
               	orq	%r15, %r14
               	xorq	%r14, %r13
               	movq	%rcx, %r14
               	andq	%rbx, %r14
               	movq	%rcx, %r15
               	xorq	$-0x1, %r15
               	andq	%r9, %r15
               	xorq	%r15, %r14
               	addq	%r14, %rsi
               	addq	$0x20da578c, %rsi       # imm = 0x20DA578C
               	addq	%rdx, %rsi
               	movq	%rax, %rdx
               	andq	%rdi, %rdx
               	movq	%rax, %r14
               	andq	%r8, %r14
               	xorq	%r14, %rdx
               	movq	%rdi, %r14
               	andq	%r8, %r14
               	xorq	%rdx, %r14
               	leaq	(%rsi,%r12), %rdx
               	addq	%r14, %rsi
               	addq	%r13, %rsi
               	movl	%edx, %r12d
               	movq	%r12, %r13
               	shrq	$0x6, %r13
               	shlq	$0x1a, %r12
               	orq	%r12, %r13
               	movl	%edx, %r12d
               	movq	%r12, %r14
               	shrq	$0xb, %r14
               	shlq	$0x15, %r12
               	orq	%r14, %r12
               	xorq	%r12, %r13
               	movl	%edx, %r12d
               	movq	%r12, %r14
               	shrq	$0x19, %r14
               	shlq	$0x7, %r12
               	orq	%r14, %r12
               	xorq	%r12, %r13
               	movl	%esi, %r12d
               	movq	%r12, %r14
               	shrq	$0x2, %r14
               	shlq	$0x1e, %r12
               	orq	%r12, %r14
               	movl	%esi, %r12d
               	movq	%r12, %r15
               	shrq	$0xd, %r15
               	shlq	$0x13, %r12
               	orq	%r15, %r12
               	xorq	%r12, %r14
               	movl	%esi, %r12d
               	movq	%r12, %r15
               	shrq	$0x16, %r15
               	shlq	$0xa, %r12
               	orq	%r15, %r12
               	xorq	%r14, %r12
               	andq	%rdx, %rcx
               	movq	%rdx, %r14
               	xorq	$-0x1, %r14
               	andq	%r14, %rbx
               	xorq	%rbx, %rcx
               	addq	%r13, %rcx
               	movl	$0xafe59c32, %r11d      # imm = 0xAFE59C32
               	addq	%r11, %rcx
               	addq	%r9, %rcx
               	movq	%rsi, %r9
               	andq	%rax, %r9
               	movq	%rsi, %rbx
               	andq	%rdi, %rbx
               	xorq	%rbx, %r9
               	andq	%rdi, %rax
               	xorq	%r9, %rax
               	leaq	(%rcx,%r8), %rdi
               	addq	%rcx, %rax
               	addq	%r12, %rax
               	leaq	-0x50(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	%edx, -0x50(%rbp)
               	movl	%edi, -0x4c(%rbp)
               	movl	%esi, -0x48(%rbp)
               	movl	%eax, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x40(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0xd2be0fd9, -0x40(%rbp) # imm = 0xD2BE0FD9
               	movl	$0x3ab9d7d7, -0x3c(%rbp) # imm = 0x3AB9D7D7
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x1bf59c86, -0x38(%rbp) # imm = 0x1BF59C86
               	movl	$0x712bdf61, -0x34(%rbp) # imm = 0x712BDF61
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	-0x80(%rbp), %edi
               	movl	-0x7c(%rbp), %eax
               	movl	-0x78(%rbp), %ecx
               	movl	-0x74(%rbp), %edx
               	movl	-0x70(%rbp), %esi
               	leaq	-0x50(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movq	%rax, %r8
               	shrq	$0x7, %r8
               	movq	%rax, %r9
               	shlq	$0x19, %r9
               	orq	%r9, %r8
               	movq	%rax, %r9
               	shrq	$0x12, %r9
               	movq	%rax, %rbx
               	shlq	$0xe, %rbx
               	orq	%rbx, %r9
               	xorq	%r9, %r8
               	movq	%rax, %r9
               	shrq	$0x3, %r9
               	xorq	%r9, %r8
               	addq	%r8, %rdi
               	movl	%edi, -0x50(%rbp)
               	movq	%rcx, %rdi
               	shrq	$0x7, %rdi
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rcx, %r8
               	shrq	$0x12, %r8
               	movq	%rcx, %r9
               	shlq	$0xe, %r9
               	orq	%r9, %r8
               	xorq	%r8, %rdi
               	movq	%rcx, %r8
               	shrq	$0x3, %r8
               	xorq	%r8, %rdi
               	addq	%rdi, %rax
               	movl	%eax, -0x4c(%rbp)
               	movq	%rdx, %rax
               	shrq	$0x7, %rax
               	movq	%rdx, %rdi
               	shlq	$0x19, %rdi
               	orq	%rdi, %rax
               	movq	%rdx, %rdi
               	shrq	$0x12, %rdi
               	movq	%rdx, %r8
               	shlq	$0xe, %r8
               	orq	%r8, %rdi
               	xorq	%rdi, %rax
               	movq	%rdx, %rdi
               	shrq	$0x3, %rdi
               	xorq	%rdi, %rax
               	addq	%rcx, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	%rsi, %rax
               	shrq	$0x7, %rax
               	movq	%rsi, %rcx
               	shlq	$0x19, %rcx
               	orq	%rcx, %rax
               	movq	%rsi, %rcx
               	shrq	$0x12, %rcx
               	movq	%rsi, %rdi
               	shlq	$0xe, %rdi
               	orq	%rdi, %rcx
               	xorq	%rcx, %rax
               	shrq	$0x3, %rsi
               	xorq	%rsi, %rax
               	addq	%rdx, %rax
               	movl	%eax, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x40(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0x5775367d, -0x40(%rbp) # imm = 0x5775367D
               	movl	$0xa2f6881f, -0x3c(%rbp) # imm = 0xA2F6881F
               	leaq	-0x40(%rbp), %rsi
               	movl	$0xefdf8f80, -0x38(%rbp) # imm = 0xEFDF8F80
               	movl	$0xd20d5047, -0x34(%rbp) # imm = 0xD20D5047
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	-0x80(%rbp), %edx
               	movl	-0x7c(%rbp), %esi
               	movl	-0x78(%rbp), %edi
               	movl	-0x74(%rbp), %r8d
               	movl	-0x68(%rbp), %eax
               	movl	-0x64(%rbp), %ecx
               	movq	%rax, %r9
               	shrq	$0x11, %r9
               	movq	%rax, %rbx
               	shlq	$0xf, %rbx
               	orq	%rbx, %r9
               	movq	%rax, %rbx
               	shrq	$0x13, %rbx
               	movq	%rax, %r12
               	shlq	$0xd, %r12
               	orq	%r12, %rbx
               	xorq	%rbx, %r9
               	shrq	$0xa, %rax
               	xorq	%r9, %rax
               	addq	%rax, %rdx
               	movq	%rcx, %rax
               	shrq	$0x11, %rax
               	movq	%rcx, %r9
               	shlq	$0xf, %r9
               	orq	%r9, %rax
               	movq	%rcx, %r9
               	shrq	$0x13, %r9
               	movq	%rcx, %rbx
               	shlq	$0xd, %rbx
               	orq	%rbx, %r9
               	xorq	%r9, %rax
               	shrq	$0xa, %rcx
               	xorq	%rcx, %rax
               	leaq	(%rsi,%rax), %rcx
               	movl	%edx, %eax
               	movq	%rax, %rsi
               	shrq	$0x11, %rsi
               	movq	%rax, %r9
               	shlq	$0xf, %r9
               	orq	%r9, %rsi
               	movq	%rax, %r9
               	shrq	$0x13, %r9
               	movq	%rax, %rbx
               	shlq	$0xd, %rbx
               	orq	%rbx, %r9
               	xorq	%r9, %rsi
               	shrq	$0xa, %rax
               	xorq	%rsi, %rax
               	leaq	(%rdi,%rax), %rsi
               	movl	%ecx, %eax
               	movq	%rax, %rdi
               	shrq	$0x11, %rdi
               	movq	%rax, %r9
               	shlq	$0xf, %r9
               	orq	%r9, %rdi
               	movq	%rax, %r9
               	shrq	$0x13, %r9
               	movq	%rax, %rbx
               	shlq	$0xd, %rbx
               	orq	%rbx, %r9
               	xorq	%r9, %rdi
               	shrq	$0xa, %rax
               	xorq	%rdi, %rax
               	addq	%r8, %rax
               	leaq	-0x50(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%edx, -0x50(%rbp)
               	movl	%ecx, -0x4c(%rbp)
               	movl	%esi, -0x48(%rbp)
               	movl	%eax, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x40(%rbp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0xf54dde0f, -0x40(%rbp) # imm = 0xF54DDE0F
               	movl	$0xe87ff5a1, -0x3c(%rbp) # imm = 0xE87FF5A1
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x2b6121c1, -0x38(%rbp) # imm = 0x2B6121C1
               	movl	$0x1209722c, -0x34(%rbp) # imm = 0x1209722C
               	leaq	-0x30(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rsi), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovmskb	%xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
