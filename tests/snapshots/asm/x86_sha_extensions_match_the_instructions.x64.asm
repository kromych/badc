
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
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	vpextrd	$0x3, %xmm1, %eax
               	movl	%eax, -0x10(%rbp)
               	vpextrd	$0x2, %xmm1, %eax
               	movl	%eax, -0xc(%rbp)
               	vpextrd	$0x1, %xmm1, %eax
               	movl	%eax, -0x8(%rbp)
               	xorl	%esi, %esi
               	vmovd	%xmm1, %eax
               	movl	%eax, -0x4(%rbp)
               	vpextrd	$0x3, %xmm0, %r9d
               	vpextrd	$0x2, %xmm0, %eax
               	vpextrd	$0x1, %xmm0, %edx
               	vmovd	%xmm0, %ecx
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
               	xorl	%esi, %esi
               	movl	%ecx, %ecx
               	vmovd	%ecx, %xmm0
               	movl	%edx, %ecx
               	vpinsrd	$0x1, %ecx, %xmm0, %xmm0
               	movl	%eax, %eax
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	movl	%r9d, %eax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0xd3dcc5a2, -0x30(%rbp) # imm = 0xD3DCC5A2
               	movl	$0xa70480db, -0x2c(%rbp) # imm = 0xA70480DB
               	movl	$0xd665ca49, -0x28(%rbp) # imm = 0xD665CA49
               	movl	$0xdaa9b5f, -0x24(%rbp) # imm = 0xDAA9B5F
               	movl	$0x3ead5c56, %eax       # imm = 0x3EAD5C56
               	movl	$0xc21fde95, -0x20(%rbp) # imm = 0xC21FDE95
               	movl	%eax, -0x1c(%rbp)
               	movl	$0xcd1d0205, -0x18(%rbp) # imm = 0xCD1D0205
               	movl	$0xaf5a022b, -0x14(%rbp) # imm = 0xAF5A022B
               	movl	-0x24(%rbp), %ecx
               	movups	-0x20(%rbp), %xmm0
               	vpextrd	$0x3, %xmm0, %edx
               	movq	%rcx, %rsi
               	shlq	$0x1e, %rsi
               	shrq	$0x2, %rcx
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	addq	%rdx, %rcx
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	movl	$0x72c4a902, %edx       # imm = 0x72C4A902
               	movq	$-0x32e2fdfb, %rsi      # imm = 0xCD1D0205
               	movq	$-0x3de0216b, %rdi      # imm = 0xC21FDE95
               	xorl	%ecx, %ecx
               	vmovd	%edi, %xmm1
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vpinsrd	$0x2, %esi, %xmm1, %xmm1
               	vpinsrd	$0x3, %edx, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
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
               	movl	-0x30(%rbp), %eax
               	movl	-0x2c(%rbp), %edx
               	movl	-0x28(%rbp), %esi
               	movl	-0x24(%rbp), %edi
               	movl	-0x18(%rbp), %r8d
               	movl	-0x14(%rbp), %r9d
               	xorq	%rax, %r8
               	vmovd	%r8d, %xmm0
               	xorq	%rdx, %r9
               	vpinsrd	$0x1, %r9d, %xmm0, %xmm0
               	xorq	%rsi, %rax
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	xorq	%rdi, %rdx
               	vpinsrd	$0x3, %edx, %xmm0, %xmm0
               	movq	$-0x5551e47c, %rcx      # imm = 0xAAAE1B84
               	movl	$0x5b90feb, %edx        # imm = 0x5B90FEB
               	movl	$0x85e82f0, %esi        # imm = 0x85E82F0
               	movl	$0x1ec1c7a7, %edi       # imm = 0x1EC1C7A7
               	xorl	%eax, %eax
               	vmovd	%edi, %xmm1
               	vpinsrd	$0x1, %esi, %xmm1, %xmm1
               	vpinsrd	$0x2, %edx, %xmm1, %xmm1
               	vpinsrd	$0x3, %ecx, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %ecx
               	cmpl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	-0x30(%rbp), %esi
               	movl	-0x2c(%rbp), %edi
               	movl	-0x28(%rbp), %edx
               	movl	-0x24(%rbp), %ecx
               	movl	-0x20(%rbp), %r8d
               	movl	-0x1c(%rbp), %r9d
               	movl	-0x18(%rbp), %ebx
               	xorq	%rbx, %rcx
               	movq	%rcx, %rbx
               	shlq	%rbx
               	shrq	$0x1f, %rcx
               	orq	%rbx, %rcx
               	xorq	%r9, %rdx
               	movq	%rdx, %r9
               	shlq	%r9
               	shrq	$0x1f, %rdx
               	orq	%rdx, %r9
               	movq	%rdi, %rdx
               	xorq	%r8, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	shrq	$0x1f, %rdx
               	orq	%rdx, %rdi
               	xorq	%rcx, %rsi
               	movl	%esi, %edx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	shrq	$0x1f, %rdx
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	vmovd	%edx, %xmm0
               	movl	%edi, %eax
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	movl	%r9d, %eax
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	movl	%ecx, %eax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movq	$-0x7e90cd4b, %rax      # imm = 0x816F32B5
               	movq	$-0x2e6ed3c1, %rcx      # imm = 0xD1912C3F
               	movq	$-0x35c94364, %rdx      # imm = 0xCA36BC9C
               	movq	$-0x5a9811d2, %rsi      # imm = 0xA567EE2E
               	xorl	%edi, %edi
               	vmovd	%esi, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
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
               	leaq	-0x30(%rbp), %r9
               	leaq	-0x20(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	$-0x10007c93, %rax      # imm = 0xEFFF836D
               	movl	$0x464e48ab, %ecx       # imm = 0x464E48AB
               	movq	$-0x60da7e8a, %rdx      # imm = 0x9F258176
               	movl	$0x11b31b64, %esi       # imm = 0x11B31B64
               	xorl	%edi, %edi
               	vmovd	%esi, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
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
               	leaq	-0x30(%rbp), %r9
               	leaq	-0x20(%rbp), %rax
               	movl	$0x1, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movl	$0x1927c1b5, %eax       # imm = 0x1927C1B5
               	movl	$0xa4a0700, %ecx        # imm = 0xA4A0700
               	movl	$0x2dea0e03, %edx       # imm = 0x2DEA0E03
               	movl	$0x5d913a37, %esi       # imm = 0x5D913A37
               	xorl	%edi, %edi
               	vmovd	%esi, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
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
               	leaq	-0x30(%rbp), %r9
               	leaq	-0x20(%rbp), %rax
               	movl	$0x2, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movl	$0x2347af9e, %eax       # imm = 0x2347AF9E
               	movl	$0x23493796, %ecx       # imm = 0x23493796
               	movq	$-0x12291c8b, %rdx      # imm = 0xEDD6E375
               	movq	$-0xd3c8514, %rsi       # imm = 0xF2C37AEC
               	xorl	%edi, %edi
               	vmovd	%esi, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
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
               	leaq	-0x30(%rbp), %r9
               	leaq	-0x20(%rbp), %rax
               	movl	$0x3, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movl	$0xf2332cf, %eax        # imm = 0xF2332CF
               	movq	$-0x5f3257f2, %rcx      # imm = 0xA0CDA80E
               	movl	$0x6112f53b, %edx       # imm = 0x6112F53B
               	movq	$-0x4b8c903c, %rsi      # imm = 0xB4736FC4
               	xorl	%edi, %edi
               	vmovd	%esi, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
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
               	movl	-0x30(%rbp), %edx
               	movl	-0x2c(%rbp), %r9d
               	movl	-0x28(%rbp), %r12d
               	movl	-0x24(%rbp), %r8d
               	movl	-0x20(%rbp), %ebx
               	movl	-0x1c(%rbp), %ecx
               	movl	-0x18(%rbp), %edi
               	movl	-0x14(%rbp), %eax
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
               	addq	%rcx, %r8
               	addq	%rcx, %rax
               	addq	%r12, %rax
               	xorl	%edi, %edi
               	movl	%edx, %ecx
               	vmovd	%ecx, %xmm0
               	movl	%r8d, %ecx
               	vpinsrd	$0x1, %ecx, %xmm0, %xmm0
               	movl	%esi, %ecx
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	movl	%eax, %eax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movl	$0x712bdf61, %eax       # imm = 0x712BDF61
               	movl	$0x1bf59c86, %ecx       # imm = 0x1BF59C86
               	movl	$0x3ab9d7d7, %edx       # imm = 0x3AB9D7D7
               	movq	$-0x2d41f027, %rsi      # imm = 0xD2BE0FD9
               	vmovd	%esi, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
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
               	movl	-0x30(%rbp), %r8d
               	movl	-0x2c(%rbp), %eax
               	movl	-0x28(%rbp), %ecx
               	movl	-0x24(%rbp), %edx
               	movl	-0x20(%rbp), %esi
               	movq	%rax, %r9
               	shrq	$0x7, %r9
               	movq	%rax, %rbx
               	shlq	$0x19, %rbx
               	orq	%rbx, %r9
               	movq	%rax, %rbx
               	shrq	$0x12, %rbx
               	movq	%rax, %r12
               	shlq	$0xe, %r12
               	orq	%r12, %rbx
               	xorq	%rbx, %r9
               	movq	%rax, %rbx
               	shrq	$0x3, %rbx
               	xorq	%rbx, %r9
               	addq	%r9, %r8
               	movl	%r8d, %r8d
               	vmovd	%r8d, %xmm0
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
               	movl	%eax, %eax
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
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
               	movl	%eax, %eax
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
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
               	movl	%eax, %eax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movq	$-0x2df2afb9, %rax      # imm = 0xD20D5047
               	movq	$-0x10207080, %rcx      # imm = 0xEFDF8F80
               	movq	$-0x5d0977e1, %rdx      # imm = 0xA2F6881F
               	movl	$0x5775367d, %esi       # imm = 0x5775367D
               	xorl	%edi, %edi
               	vmovd	%esi, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
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
               	movl	-0x30(%rbp), %edx
               	movl	-0x2c(%rbp), %esi
               	movl	-0x28(%rbp), %edi
               	movl	-0x24(%rbp), %r8d
               	movl	-0x18(%rbp), %eax
               	movl	-0x14(%rbp), %ecx
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
               	addq	%rdx, %rax
               	movq	%rcx, %rdx
               	shrq	$0x11, %rdx
               	movq	%rcx, %r9
               	shlq	$0xf, %r9
               	orq	%r9, %rdx
               	movq	%rcx, %r9
               	shrq	$0x13, %r9
               	movq	%rcx, %rbx
               	shlq	$0xd, %rbx
               	orq	%rbx, %r9
               	xorq	%r9, %rdx
               	shrq	$0xa, %rcx
               	xorq	%rdx, %rcx
               	addq	%rsi, %rcx
               	movl	%eax, %eax
               	movq	%rax, %rdx
               	shrq	$0x11, %rdx
               	movq	%rax, %rsi
               	shlq	$0xf, %rsi
               	orq	%rsi, %rdx
               	movq	%rax, %rsi
               	shrq	$0x13, %rsi
               	movq	%rax, %r9
               	shlq	$0xd, %r9
               	orq	%r9, %rsi
               	xorq	%rsi, %rdx
               	movq	%rax, %rsi
               	shrq	$0xa, %rsi
               	xorq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shrq	$0x11, %rdx
               	movq	%rcx, %rdi
               	shlq	$0xf, %rdi
               	orq	%rdi, %rdx
               	movq	%rcx, %rdi
               	shrq	$0x13, %rdi
               	movq	%rcx, %r9
               	shlq	$0xd, %r9
               	orq	%r9, %rdi
               	xorq	%rdi, %rdx
               	movq	%rcx, %rdi
               	shrq	$0xa, %rdi
               	xorq	%rdi, %rdx
               	leaq	(%r8,%rdx), %rdi
               	xorl	%edx, %edx
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %ecx, %xmm0, %xmm0
               	movl	%esi, %eax
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	movl	%edi, %eax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movl	$0x1209722c, %eax       # imm = 0x1209722C
               	movl	$0x2b6121c1, %ecx       # imm = 0x2B6121C1
               	movq	$-0x17800a5f, %rsi      # imm = 0xE87FF5A1
               	movq	$-0xab221f1, %rdi       # imm = 0xF54DDE0F
               	vmovd	%edi, %xmm1
               	vpinsrd	$0x1, %esi, %xmm1, %xmm1
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	pmovmskb	%xmm0, %eax
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
