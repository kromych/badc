
avx_floating_and_fma_follow_the_sdm.x64:	file format elf64-x86-64

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

<_mm256_permute_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x20(%rbp), %rax
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	xorl	%ecx, %ecx
               	vpextrd	$0x3, %xmm1, %edx
               	movslq	%edx, %rdx
               	vmovd	%edx, %xmm2
               	vpextrd	$0x2, %xmm1, %edx
               	movslq	%edx, %rdx
               	movapd	%xmm2, %xmm1
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpinsrd	$0x2, %edx, %xmm1, %xmm1
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	movapd	%xmm1, %xmm2
               	vpinsrd	$0x3, %edx, %xmm2, %xmm2
               	vmovups	(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrd	$0x3, %xmm1, %edx
               	movslq	%edx, %rdx
               	vmovd	%edx, %xmm3
               	vpextrd	$0x2, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	movapd	%xmm3, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x2, %ecx, %xmm1, %xmm1
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, (%rax)
               	vzeroupper
               	leave
               	retq

<_mm256_shuffle_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x20(%rbp), %rax
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	xorl	%ecx, %ecx
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	vmovd	%edx, %xmm2
               	vpextrd	$0x3, %xmm0, %edx
               	movslq	%edx, %rdx
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x1, %edx, %xmm0, %xmm0
               	vpextrd	$0x1, %xmm1, %edx
               	movslq	%edx, %rdx
               	vpinsrd	$0x2, %edx, %xmm0, %xmm0
               	vpextrd	$0x2, %xmm1, %edx
               	movslq	%edx, %rdx
               	movapd	%xmm0, %xmm2
               	vpinsrd	$0x3, %edx, %xmm2, %xmm2
               	vmovups	(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm0
               	vmovups	0x20(%rsp), %ymm1
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	vmovd	%edx, %xmm3
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	movapd	%xmm3, %xmm0
               	vpinsrd	$0x1, %ecx, %xmm0, %xmm0
               	vpextrd	$0x1, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	vpextrd	$0x2, %xmm1, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, (%rax)
               	vzeroupper
               	leave
               	retq

<_mm256_permute_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	movq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	leave
               	retq

<_mm256_shuffle_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	(%rsp), %rcx
               	movq	0x18(%rsp), %rdx
               	movq	0x28(%rsp), %rsi
               	movq	0x30(%rsp), %rdi
               	movq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_blend_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0xa5, %esi
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	sarxq	%rax, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movl	(%rdx,%rax,4), %edi
               	movl	%edi, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_blend_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x9, %esi
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	sarxq	%rax, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movq	(%rdx,%rax,8), %rdi
               	movq	%rdi, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_blendv_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x40(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	movl	(%rsi,%rax,4), %edi
               	testl	%edi, %edi
               	jge	<addr>
               	movl	(%rdx,%rax,4), %edi
               	movl	%edi, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_blendv_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x40(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	movq	(%rsi,%rax,8), %rdi
               	testq	%rdi, %rdi
               	jge	<addr>
               	movq	(%rdx,%rax,8), %rdi
               	movq	%rdi, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<__badc_cmp_holds>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	ucomisd	%xmm1, %xmm0
               	setp	%al
               	movzbq	%al, %rax
               	ucomisd	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	ucomisd	%xmm1, %xmm0
               	sete	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	movq	%rdi, %rsi
               	andq	$0x3, %rsi
               	cmpl	$0x1, %esi
               	movl	$0x1, %r8d
               	je	<addr>
               	cmpl	$0x2, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	%rdi, %r9
               	sarq	$0x4, %r9
               	andq	$0x1, %r9
               	xorq	%r9, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	comisd	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	movl	%esi, -0x8(%rbp)
               	movl	-0x8(%rbp), %esi
               	movq	%rdi, %rsi
               	andq	$0xf, %rsi
               	cmpl	$0xf, %esi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rsi,8), %r10
               	jmpq	*%r10
               	movq	%rdx, %rax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	leave
               	retq
               	testl	%edx, %edx
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	testl	%ecx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movl	$0x1, %ecx
               	testl	%edx, %edx
               	jne	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0x1, %edx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rax, %rdx
               	movq	%rdx, %rax
               	leave
               	retq
               	movl	$0x1, %esi
               	testl	%ecx, %ecx
               	jne	<addr>
               	movslq	%edx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	leave
               	retq
               	movq	%rsi, %rcx
               	jmp	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leave
               	retq
               	xorl	%edx, %edx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %rax
               	leave
               	retq
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%edx, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testl	%eax, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, %rax
               	leave
               	retq
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movq	%r8, %rax
               	leave
               	retq
               	movq	%r8, %rsi
               	jmp	<addr>

<_mm256_cmp_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rsi, %rbx
               	movss	(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x20(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x40(%rsp)
               	movss	0x4(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x24(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x44(%rsp)
               	movss	0x8(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x28(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x48(%rsp)
               	movss	0xc(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x2c(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x4c(%rsp)
               	movss	0x10(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x30(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x50(%rsp)
               	movss	0x14(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x34(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x54(%rsp)
               	movss	0x18(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x38(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x58(%rsp)
               	movss	0x1c(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x3c(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x5c(%rsp)
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_cmp_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rsi, %rbx
               	movsd	(%rsp), %xmm0
               	movsd	0x20(%rsp), %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x40(%rsp)
               	movsd	0x8(%rsp), %xmm0
               	movsd	0x28(%rsp), %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x48(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x50(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	movsd	0x38(%rsp), %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x58(%rsp)
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<rnd_f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xc, %ecx
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%ecx
               	movl	(%rsi,%rdx,4), %eax
               	movl	%eax, -0x10(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7f800000, %rcx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movss	-0x8(%rbp), %xmm0
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	jmp	<addr>
               	movl	$0xb, %ecx
               	jmp	<addr>
               	shrq	$0x10, %rax
               	jmp	<addr>

<rnd_d>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xb, %ecx
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%ecx
               	movq	(%rsi,%rdx,8), %rax
               	movq	%rax, -0x10(%rbp)
               	movabsq	$0x7ff0000000000000, %rcx # imm = 0x7FF0000000000000
               	andq	%rax, %rcx
               	movabsq	$0x7ff0000000000000, %r11 # imm = 0x7FF0000000000000
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$0xfffffffffffff, %rcx  # imm = 0xFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movabsq	$0x8000000000000, %r11  # imm = 0x8000000000000
               	orq	%r11, %rax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	jmp	<addr>

<fnv>:
               	xorl	%eax, %eax
               	movabsq	$0x100000001b3, %rcx    # imm = 0x100000001B3
               	cmpl	%edx, %eax
               	jge	<addr>
               	movzbq	(%rsi,%rax), %r8
               	xorq	%r8, %rdi
               	imulq	%rcx, %rdi
               	incq	%rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	retq

<arith>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x4e0, %rsp            # imm = 0x4E0
               	subq	$0x9a0, %rsp            # imm = 0x9A0
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x70(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x78(%rbp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x80(%rbp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x88(%rbp), %r10
               	movq	%r10, 0x78(%rsp)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	addps	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	addps	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	subps	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	subps	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	mulps	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	mulps	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	divps	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	divps	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	minps	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	minps	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	maxps	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	maxps	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	sqrtps	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	sqrtps	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm2
               	vmovups	0x20(%rsp), %ymm3
               	vmovdqa	%xmm2, %xmm0
               	vmovdqa	%xmm3, %xmm1
               	xorl	%eax, %eax
               	vpermilps	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0,0,0]
               	vpermilps	$0x0, %xmm1, %xmm5 # xmm5 = xmm1[0,0,0,0]
               	subss	%xmm5, %xmm4
               	vmovd	%xmm4, %r11d
               	vmovd	%r11d, %xmm4
               	vpermilps	$0x1, %xmm0, %xmm5 # xmm5 = xmm0[1,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm6 # xmm6 = xmm1[1,0,0,0]
               	addss	%xmm6, %xmm5
               	vmovd	%xmm5, %r11d
               	vpinsrd	$0x1, %r11d, %xmm4, %xmm4
               	vpermilps	$0x2, %xmm0, %xmm5 # xmm5 = xmm0[2,0,0,0]
               	vpermilps	$0x2, %xmm1, %xmm6 # xmm6 = xmm1[2,0,0,0]
               	subss	%xmm6, %xmm5
               	vmovd	%xmm5, %r11d
               	vpinsrd	$0x2, %r11d, %xmm4, %xmm4
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	addss	%xmm1, %xmm0
               	vmovd	%xmm0, %r11d
               	vpinsrd	$0x3, %r11d, %xmm4, %xmm4
               	vextracti128	$0x1, %ymm2, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vpermilps	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0,0,0]
               	subss	%xmm3, %xmm2
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm5 # xmm5 = xmm1[1,0,0,0]
               	addss	%xmm5, %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm2, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x2, %xmm1, %xmm5 # xmm5 = xmm1[2,0,0,0]
               	subss	%xmm5, %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm2, %xmm2
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	addss	%xmm1, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm4, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm2
               	vmovups	0x20(%rsp), %ymm3
               	vmovdqa	%xmm2, %xmm0
               	vmovdqa	%xmm3, %xmm1
               	xorl	%eax, %eax
               	vpermilps	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm5 # xmm5 = xmm0[1,0,0,0]
               	addss	%xmm5, %xmm4
               	vmovd	%xmm4, %r11d
               	vmovd	%r11d, %xmm4
               	vpermilps	$0x2, %xmm0, %xmm5 # xmm5 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vaddss	%xmm0, %xmm5, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm4, %xmm0
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	vpermilps	$0x0, %xmm1, %xmm4 # xmm4 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm5 # xmm5 = xmm1[1,0,0,0]
               	addss	%xmm5, %xmm4
               	vmovd	%xmm4, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm1, %xmm4 # xmm4 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	vaddss	%xmm1, %xmm4, %xmm1
               	vmovd	%xmm1, %r11d
               	movapd	%xmm0, %xmm4
               	vpinsrd	$0x3, %r11d, %xmm4, %xmm4
               	vextracti128	$0x1, %ymm2, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	addss	%xmm3, %xmm2
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vaddss	%xmm0, %xmm3, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	vpermilps	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm3 # xmm3 = xmm1[1,0,0,0]
               	addss	%xmm3, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm1, %xmm2 # xmm2 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	vaddss	%xmm1, %xmm2, %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm4, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm2
               	vmovups	0x20(%rsp), %ymm3
               	vmovdqa	%xmm2, %xmm0
               	vmovdqa	%xmm3, %xmm1
               	xorl	%eax, %eax
               	vpermilps	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm5 # xmm5 = xmm0[1,0,0,0]
               	subss	%xmm5, %xmm4
               	vmovd	%xmm4, %r11d
               	vmovd	%r11d, %xmm4
               	vpermilps	$0x2, %xmm0, %xmm5 # xmm5 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	subss	%xmm0, %xmm5
               	vmovd	%xmm5, %r11d
               	movapd	%xmm4, %xmm0
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	vpermilps	$0x0, %xmm1, %xmm4 # xmm4 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm5 # xmm5 = xmm1[1,0,0,0]
               	subss	%xmm5, %xmm4
               	vmovd	%xmm4, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm1, %xmm4 # xmm4 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	subss	%xmm1, %xmm4
               	vmovd	%xmm4, %r11d
               	movapd	%xmm0, %xmm4
               	vpinsrd	$0x3, %r11d, %xmm4, %xmm4
               	vextracti128	$0x1, %ymm2, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	subss	%xmm3, %xmm2
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	subss	%xmm0, %xmm3
               	vmovd	%xmm3, %r11d
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	vpermilps	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm3 # xmm3 = xmm1[1,0,0,0]
               	subss	%xmm3, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm1, %xmm2 # xmm2 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	subss	%xmm1, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm4, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x14b8(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	addpd	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	addpd	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	subpd	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	subpd	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	mulpd	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	mulpd	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	divpd	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	divpd	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	minpd	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	minpd	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	maxpd	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	maxpd	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	sqrtpd	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	sqrtpd	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	xorl	%eax, %eax
               	vpermilpd	$0x0, %xmm2, %xmm4 # xmm4 = xmm2[0,0]
               	vpermilpd	$0x0, %xmm3, %xmm5 # xmm5 = xmm3[0,0]
               	subsd	%xmm5, %xmm4
               	vmovq	%xmm4, %r11
               	vmovq	%r11, %xmm4
               	vpermilpd	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
               	vpermilpd	$0x1, %xmm3, %xmm3 # xmm3 = xmm3[1,0]
               	addsd	%xmm3, %xmm2
               	vmovq	%xmm2, %r11
               	movapd	%xmm4, %xmm2
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpermilpd	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm1, %xmm4 # xmm4 = xmm1[0,0]
               	subsd	%xmm4, %xmm3
               	vmovq	%xmm3, %r11
               	vmovq	%r11, %xmm3
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0]
               	addsd	%xmm1, %xmm0
               	vmovq	%xmm0, %r11
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	xorl	%eax, %eax
               	vpermilpd	$0x0, %xmm2, %xmm4 # xmm4 = xmm2[0,0]
               	vpermilpd	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
               	vaddsd	%xmm2, %xmm4, %xmm2
               	vmovq	%xmm2, %r11
               	vmovq	%r11, %xmm2
               	vpermilpd	$0x0, %xmm3, %xmm4 # xmm4 = xmm3[0,0]
               	vpermilpd	$0x1, %xmm3, %xmm3 # xmm3 = xmm3[1,0]
               	vaddsd	%xmm3, %xmm4, %xmm3
               	vmovq	%xmm3, %r11
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpermilpd	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0]
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	vaddsd	%xmm0, %xmm3, %xmm0
               	vmovq	%xmm0, %r11
               	vmovq	%r11, %xmm0
               	vpermilpd	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0]
               	vpermilpd	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0]
               	vaddsd	%xmm1, %xmm3, %xmm1
               	vmovq	%xmm1, %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	xorl	%eax, %eax
               	vpermilpd	$0x0, %xmm2, %xmm4 # xmm4 = xmm2[0,0]
               	vpermilpd	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
               	subsd	%xmm2, %xmm4
               	vmovq	%xmm4, %r11
               	vmovq	%r11, %xmm2
               	vpermilpd	$0x0, %xmm3, %xmm4 # xmm4 = xmm3[0,0]
               	vpermilpd	$0x1, %xmm3, %xmm3 # xmm3 = xmm3[1,0]
               	subsd	%xmm3, %xmm4
               	vmovq	%xmm4, %r11
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpermilpd	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0]
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	subsd	%xmm0, %xmm3
               	vmovq	%xmm3, %r11
               	vmovq	%r11, %xmm0
               	vpermilpd	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0]
               	vpermilpd	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0]
               	subsd	%xmm1, %xmm3
               	vmovq	%xmm3, %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x14b8(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	xorl	%esi, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	xorl	%esi, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	xorl	%edi, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x580(%rsp), %rdx
               	movups	%xmm0, 0x580(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	xorl	%edi, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x590(%rsp), %rdx
               	movups	%xmm0, 0x590(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1420(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x1420(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x1, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x5a0(%rsp), %rdx
               	movups	%xmm0, 0x5a0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x1, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x5b0(%rsp), %rdx
               	movups	%xmm0, 0x5b0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1388(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x1388(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x2, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xe0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x2, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x2, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x5c0(%rsp), %rdx
               	movups	%xmm0, 0x5c0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x2, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x5d0(%rsp), %rdx
               	movups	%xmm0, 0x5d0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x12f0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x12f0(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x3, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x100(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x3, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x3, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x5e0(%rsp), %rdx
               	movups	%xmm0, 0x5e0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x3, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x5f0(%rsp), %rdx
               	movups	%xmm0, 0x5f0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1258(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x1258(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x4, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x120(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x4, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x4, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x600(%rsp), %rsi
               	movups	%xmm0, 0x600(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x4, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x610(%rsp), %rsi
               	movups	%xmm0, 0x610(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x11c0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x11c0(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x5, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x140(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x5, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x5, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x620(%rsp), %rsi
               	movups	%xmm0, 0x620(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x5, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x630(%rsp), %rsi
               	movups	%xmm0, 0x630(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1128(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1128(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x6, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x160(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x6, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x6, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x640(%rsp), %rsi
               	movups	%xmm0, 0x640(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x6, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x650(%rsp), %rsi
               	movups	%xmm0, 0x650(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1090(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1090(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x7, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x180(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x7, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x7, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x660(%rsp), %rsi
               	movups	%xmm0, 0x660(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x7, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x670(%rsp), %rsi
               	movups	%xmm0, 0x670(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xff8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xff8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x8, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x1a0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x8, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x8, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x680(%rsp), %rsi
               	movups	%xmm0, 0x680(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x8, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x690(%rsp), %rsi
               	movups	%xmm0, 0x690(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xf60(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xf60(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x9, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x1c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x9, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x9, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x6a0(%rsp), %rsi
               	movups	%xmm0, 0x6a0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x9, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x6b0(%rsp), %rsi
               	movups	%xmm0, 0x6b0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xec8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xec8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xa, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x1e0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xa, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0xa, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x6c0(%rsp), %rsi
               	movups	%xmm0, 0x6c0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0xa, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x6d0(%rsp), %rsi
               	movups	%xmm0, 0x6d0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xe30(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xe30(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xb, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x200(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xb, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0xb, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x6e0(%rsp), %rsi
               	movups	%xmm0, 0x6e0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0xb, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x6f0(%rsp), %rsi
               	movups	%xmm0, 0x6f0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xd98(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xd98(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xc, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x220(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xc, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0xc, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x700(%rsp), %rsi
               	movups	%xmm0, 0x700(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0xc, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x710(%rsp), %rsi
               	movups	%xmm0, 0x710(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xd00(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xd00(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xd, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x240(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xd, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0xd, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x720(%rsp), %rsi
               	movups	%xmm0, 0x720(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0xd, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x730(%rsp), %rsi
               	movups	%xmm0, 0x730(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xc68(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xc68(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xe, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x260(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xe, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0xe, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x740(%rsp), %rsi
               	movups	%xmm0, 0x740(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0xe, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x750(%rsp), %rsi
               	movups	%xmm0, 0x750(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xbd0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xbd0(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xf, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x280(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xf, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0xf, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x760(%rsp), %rsi
               	movups	%xmm0, 0x760(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0xf, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x770(%rsp), %rsi
               	movups	%xmm0, 0x770(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xb38(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xb38(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x10, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x2a0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x10, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x10, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x780(%rsp), %rsi
               	movups	%xmm0, 0x780(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x10, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x790(%rsp), %rsi
               	movups	%xmm0, 0x790(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xaa0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xaa0(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x11, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x2c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x11, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x11, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x7a0(%rsp), %rsi
               	movups	%xmm0, 0x7a0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x11, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x7b0(%rsp), %rsi
               	movups	%xmm0, 0x7b0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xa08(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xa08(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x12, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x2e0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x12, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x12, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x7c0(%rsp), %rsi
               	movups	%xmm0, 0x7c0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x12, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x7d0(%rsp), %rsi
               	movups	%xmm0, 0x7d0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x970(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x970(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x13, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x300(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x13, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x13, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x7e0(%rsp), %rsi
               	movups	%xmm0, 0x7e0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x13, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x7f0(%rsp), %rsi
               	movups	%xmm0, 0x7f0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x8d8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x8d8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x14, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x320(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x14, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x14, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x800(%rsp), %rsi
               	movups	%xmm0, 0x800(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x14, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x810(%rsp), %rsi
               	movups	%xmm0, 0x810(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x840(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x840(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x15, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x340(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x15, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x15, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x820(%rsp), %rsi
               	movups	%xmm0, 0x820(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x15, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x830(%rsp), %rsi
               	movups	%xmm0, 0x830(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x7a8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x7a8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x16, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x360(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x16, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x16, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x840(%rsp), %rsi
               	movups	%xmm0, 0x840(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x16, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x850(%rsp), %rsi
               	movups	%xmm0, 0x850(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x710(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x710(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x17, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x380(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x17, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x17, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x860(%rsp), %rsi
               	movups	%xmm0, 0x860(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x17, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x870(%rsp), %rsi
               	movups	%xmm0, 0x870(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x678(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x678(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x18, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x3a0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x18, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x18, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x880(%rsp), %rsi
               	movups	%xmm0, 0x880(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x18, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x890(%rsp), %rsi
               	movups	%xmm0, 0x890(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x5e0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x5e0(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x19, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x3c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x19, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x19, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x8a0(%rsp), %rsi
               	movups	%xmm0, 0x8a0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x19, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x8b0(%rsp), %rsi
               	movups	%xmm0, 0x8b0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x548(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x548(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1a, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x3e0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1a, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x1a, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x8c0(%rsp), %rsi
               	movups	%xmm0, 0x8c0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x1a, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x8d0(%rsp), %rsi
               	movups	%xmm0, 0x8d0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x4b0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x4b0(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1b, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x400(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1b, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x1b, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x8e0(%rsp), %rsi
               	movups	%xmm0, 0x8e0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x1b, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x8f0(%rsp), %rsi
               	movups	%xmm0, 0x8f0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x418(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x418(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1c, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x420(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1c, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x1c, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x900(%rsp), %rsi
               	movups	%xmm0, 0x900(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x1c, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x910(%rsp), %rsi
               	movups	%xmm0, 0x910(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x380(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x380(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1d, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x440(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1d, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x1d, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x920(%rsp), %rsi
               	movups	%xmm0, 0x920(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x1d, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x930(%rsp), %rsi
               	movups	%xmm0, 0x930(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x2e8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x2e8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1e, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x460(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1e, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x1e, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x940(%rsp), %rsi
               	movups	%xmm0, 0x940(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x1e, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x950(%rsp), %rsi
               	movups	%xmm0, 0x950(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x250(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x250(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1f, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x480(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1f, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movl	$0x1f, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	cvtss2sd	%xmm1, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0,0,0]
               	cvtss2sd	%xmm0, %xmm0
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	negq	%rax
               	movslq	%eax, %rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x960(%rsp), %rsi
               	movups	%xmm0, 0x960(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x14e0(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	movl	$0x1f, %edi
               	movups	-0x14e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movups	-0x14e0(%rbp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leaq	0x970(%rsp), %rsi
               	movups	%xmm0, 0x970(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	vmovups	(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm1
               	cvtps2dq	%xmm1, %xmm1
               	cvtps2dq	%xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	0x4a0(%rsp), %rsi
               	vmovups	%ymm0, 0x4a0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm1
               	cvttps2dq	%xmm1, %xmm1
               	cvttps2dq	%xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x20(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	cvtdq2ps	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x4c0(%rsp), %rsi
               	vmovups	%ymm0, 0x4c0(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	cvtpd2ps	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	cvtpd2ps	%xmm0, %xmm0
               	xorl	%eax, %eax
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%ecx, %xmm2
               	vpextrd	$0x1, %xmm1, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	leaq	0x980(%rsp), %rsi
               	movups	%xmm0, 0x980(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	cvtps2pd	%xmm0, %xmm1
               	xorl	%eax, %eax
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%ecx, %xmm2
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvtps2pd	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	cvtpd2dq	%xmm0, %xmm0
               	vmovups	0x40(%rsp), %ymm1
               	vextracti128	$0x1, %ymm1, %xmm1
               	cvtpd2dq	%xmm1, %xmm1
               	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
               	leaq	0x990(%rsp), %rsi
               	movups	%xmm0, 0x990(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	cvttpd2dq	%xmm0, %xmm0
               	vmovups	0x40(%rsp), %ymm1
               	vextracti128	$0x1, %ymm1, %xmm1
               	cvttpd2dq	%xmm1, %xmm1
               	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
               	leaq	0x80(%rsp), %rsi
               	movups	%xmm0, 0x80(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x60(%rsp), %ymm0
               	cvtdq2pd	%xmm0, %xmm1
               	pshufd	$0xe, %xmm0, %xmm0      # xmm0 = xmm0[2,3,0,0]
               	cvtdq2pd	%xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	andps	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	andps	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x4e0(%rsp), %rsi
               	vmovups	%ymm0, 0x4e0(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	vmovq	%xmm2, %rax
               	xorq	$-0x1, %rax
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm4
               	vpextrq	$0x1, %xmm2, %rax
               	xorq	$-0x1, %rax
               	movapd	%xmm4, %xmm2
               	vpinsrq	$0x1, %rax, %xmm2, %xmm2
               	pand	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmovq	%xmm0, %rax
               	xorq	$-0x1, %rax
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm3
               	vpextrq	$0x1, %xmm0, %rax
               	xorq	$-0x1, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	pand	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	orps	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	orps	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	pxor	%xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	pxor	%xmm1, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	xorl	%eax, %eax
               	vmovd	%xmm2, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%ecx, %xmm4
               	vmovd	%xmm3, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x1, %ecx, %xmm4, %xmm4
               	vpextrd	$0x1, %xmm2, %ecx
               	movslq	%ecx, %rcx
               	movapd	%xmm4, %xmm2
               	vpinsrd	$0x2, %ecx, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm3, %ecx
               	movslq	%ecx, %rcx
               	vpinsrd	$0x3, %ecx, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	vmovd	%ecx, %xmm3
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm3, %xmm3
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpextrd	$0x1, %xmm1, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovdqa	%xmm0, %xmm2
               	vmovdqa	%xmm1, %xmm3
               	xorl	%eax, %eax
               	vpextrq	$0x1, %xmm2, %rcx
               	vmovq	%rcx, %xmm2
               	vpextrq	$0x1, %xmm3, %rcx
               	vpinsrq	$0x1, %rcx, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm0, %rcx
               	vmovq	%rcx, %xmm0
               	vpextrq	$0x1, %xmm1, %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x9c, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x6, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x1b, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	movl	$0x5, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vperm2i128	$0x21, %ymm1, %ymm0, %ymm0 # ymm0 = ymm0[2,3],ymm1[0,1]
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vperm2i128	$0x30, %ymm1, %ymm0, %ymm0 # ymm0 = ymm0[0,1],ymm1[2,3]
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xa5, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x9, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x560(%rsp), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	leaq	0xa0(%rsp), %r9
               	leaq	0x40(%rsp), %rsi
               	leaq	0x80(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	subq	$0x60, %rsp
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x560(%rsp), %rax
               	leaq	0x500(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x560(%rsp), %rdi
               	leaq	0x40(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	leaq	0xa0(%rsp), %r9
               	leaq	(%rsp), %rsi
               	leaq	0x80(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	subq	$0x60, %rsp
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x560(%rsp), %rax
               	leaq	0x520(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	orq	%rcx, %rax
               	vmovups	(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm0
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	setl	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	vpextrd	$0x2, %xmm0, %edx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	setl	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	vpextrd	$0x3, %xmm0, %edx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	setl	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovq	%xmm0, %rax
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	vpextrq	$0x1, %xmm0, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	vmovups	0x40(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm0
               	vmovq	%xmm0, %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	vpextrq	$0x1, %xmm0, %rdx
               	testq	%rdx, %rdx
               	setl	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm1
               	vmovdqa	%xmm1, %xmm0
               	xorl	%eax, %eax
               	vpermilps	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0,0,0]
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm2, %xmm2
               	vpermilps	$0x3, %xmm0, %xmm3 # xmm3 = xmm0[3,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm2, %xmm2
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vmovd	%xmm0, %r11d
               	vpinsrd	$0x3, %r11d, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm1, %xmm0
               	vpermilps	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0,0,0]
               	vmovd	%xmm1, %r11d
               	vmovd	%r11d, %xmm1
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm3 # xmm3 = xmm0[3,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x540(%rsp), %rsi
               	vmovups	%ymm0, 0x540(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x20(%rsp), %ymm1
               	vmovdqa	%xmm1, %xmm0
               	xorl	%eax, %eax
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm2, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm2, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm0 # xmm0 = xmm0[2,0,0,0]
               	vmovd	%xmm0, %r11d
               	vpinsrd	$0x3, %r11d, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm1, %xmm0
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	vmovd	%xmm1, %r11d
               	vmovd	%r11d, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpermilps	$0x2, %xmm0, %xmm0 # xmm0 = xmm0[2,0,0,0]
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovdqa	%xmm2, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	xorl	%eax, %eax
               	vpermilpd	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0]
               	vmovq	%xmm2, %r11
               	vmovq	%r11, %xmm2
               	vpermilpd	$0x0, %xmm1, %xmm1 # xmm1 = xmm1[0,0]
               	vmovq	%xmm1, %r11
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	vmovq	%xmm2, %r11
               	vmovq	%r11, %xmm2
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	vmovq	%xmm0, %r11
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	(%rsp), %ymm0
               	vextracti128	$0x1, %ymm0, %xmm0
               	leaq	0x80(%rsp), %rsi
               	movups	%xmm0, 0x80(%rsp)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vmovups	0x60(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	-0x14d0(%rbp), %rcx
               	leaq	(%rsp), %rdx
               	leaq	0x80(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rcx
               	movl	-0x14c4(%rbp), %eax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movl	%eax, 0x80(%rsp)
               	movl	%eax, 0x84(%rsp)
               	movl	%eax, 0x88(%rsp)
               	movl	%eax, 0x8c(%rsp)
               	movl	%eax, 0x90(%rsp)
               	movl	%eax, 0x94(%rsp)
               	movl	%eax, 0x98(%rsp)
               	movl	%eax, 0x9c(%rsp)
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	-0x14d0(%rbp), %rax
               	movq	-0x14c8(%rbp), %rcx
               	movq	-0x14c0(%rbp), %rdx
               	movq	-0x14b8(%rbp), %rdi
               	leaq	0x80(%rsp), %rsi
               	movq	%rax, 0x80(%rsp)
               	movq	%rcx, 0x88(%rsp)
               	movq	%rdx, 0x90(%rsp)
               	movq	%rdi, 0x98(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movss	0x20(%rsp), %xmm0
               	movss	%xmm0, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
               	movl	$0x4, %edx
               	vzeroupper
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	vzeroupper
               	leave
               	retq

<fused>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	subq	$0x140, %rsp            # imm = 0x140
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x70(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x78(%rbp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x80(%rbp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x88(%rbp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x90(%rbp), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x98(%rbp), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0xa0(%rbp), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0xa8(%rbp), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0xb0(%rbp), %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0xb8(%rbp), %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0xc0(%rbp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	0xc8(%rbp), %r10
               	movq	%r10, 0xb8(%rsp)
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x50(%rbp)
               	vmovups	0x60(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x60(%rbp)
               	vmovups	0x80(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x70(%rbp)
               	vmovups	0xa0(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm14
               	movups	%xmm14, -0x80(%rbp)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	leaq	0x100(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x120(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movss	0x100(%rsp), %xmm0
               	movss	0x120(%rsp), %xmm1
               	movss	0xe0(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0x104(%rsp), %xmm0
               	movss	0x124(%rsp), %xmm1
               	movss	0xe4(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc4(%rsp)
               	movss	0x108(%rsp), %xmm0
               	movss	0x128(%rsp), %xmm1
               	movss	0xe8(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc8(%rsp)
               	movss	0x10c(%rsp), %xmm0
               	movss	0x12c(%rsp), %xmm1
               	movss	0xec(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xcc(%rsp)
               	movss	0x110(%rsp), %xmm0
               	movss	0x130(%rsp), %xmm1
               	movss	0xf0(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd0(%rsp)
               	movss	0x114(%rsp), %xmm0
               	movss	0x134(%rsp), %xmm1
               	movss	0xf4(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd4(%rsp)
               	movss	0x118(%rsp), %xmm0
               	movss	0x138(%rsp), %xmm1
               	movss	0xf8(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd8(%rsp)
               	movss	0x11c(%rsp), %xmm0
               	movss	0x13c(%rsp), %xmm1
               	movss	0xfc(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xdc(%rsp)
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	leaq	0x100(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x120(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movss	0x100(%rsp), %xmm0
               	movss	0x120(%rsp), %xmm1
               	movss	0xe0(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0x104(%rsp), %xmm0
               	movss	0x124(%rsp), %xmm1
               	movss	0xe4(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc4(%rsp)
               	movss	0x108(%rsp), %xmm0
               	movss	0x128(%rsp), %xmm1
               	movss	0xe8(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc8(%rsp)
               	movss	0x10c(%rsp), %xmm0
               	movss	0x12c(%rsp), %xmm1
               	movss	0xec(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xcc(%rsp)
               	movss	0x110(%rsp), %xmm0
               	movss	0x130(%rsp), %xmm1
               	movss	0xf0(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd0(%rsp)
               	movss	0x114(%rsp), %xmm0
               	movss	0x134(%rsp), %xmm1
               	movss	0xf4(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd4(%rsp)
               	movss	0x118(%rsp), %xmm0
               	movss	0x138(%rsp), %xmm1
               	movss	0xf8(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd8(%rsp)
               	movss	0x11c(%rsp), %xmm0
               	movss	0x13c(%rsp), %xmm1
               	movss	0xfc(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xdc(%rsp)
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	leaq	0x100(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x120(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movss	0x100(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x120(%rsp), %xmm1
               	movss	0xe0(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0x104(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x124(%rsp), %xmm1
               	movss	0xe4(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc4(%rsp)
               	movss	0x108(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x128(%rsp), %xmm1
               	movss	0xe8(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc8(%rsp)
               	movss	0x10c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x12c(%rsp), %xmm1
               	movss	0xec(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xcc(%rsp)
               	movss	0x110(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x130(%rsp), %xmm1
               	movss	0xf0(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd0(%rsp)
               	movss	0x114(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x134(%rsp), %xmm1
               	movss	0xf4(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd4(%rsp)
               	movss	0x118(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x138(%rsp), %xmm1
               	movss	0xf8(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd8(%rsp)
               	movss	0x11c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x13c(%rsp), %xmm1
               	movss	0xfc(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xdc(%rsp)
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x40(%rsp), %rdx
               	leaq	0x100(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x120(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movss	0x100(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x120(%rsp), %xmm1
               	movss	0xe0(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0x104(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x124(%rsp), %xmm1
               	movss	0xe4(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc4(%rsp)
               	movss	0x108(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x128(%rsp), %xmm1
               	movss	0xe8(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xc8(%rsp)
               	movss	0x10c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x12c(%rsp), %xmm1
               	movss	0xec(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xcc(%rsp)
               	movss	0x110(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x130(%rsp), %xmm1
               	movss	0xf0(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd0(%rsp)
               	movss	0x114(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x134(%rsp), %xmm1
               	movss	0xf4(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd4(%rsp)
               	movss	0x118(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x138(%rsp), %xmm1
               	movss	0xf8(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xd8(%rsp)
               	movss	0x11c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x13c(%rsp), %xmm1
               	movss	0xfc(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xdc(%rsp)
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x40(%rsp), %rdi
               	leaq	0x100(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x120(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	leaq	0xc0(%rsp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm1
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm2
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	cmpl	$0x1, %r8d
               	jne	<addr>
               	leaq	0xe0(%rsp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0xe0(%rsp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vfmadd231ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x40(%rsp), %rdi
               	leaq	0x100(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x120(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	leaq	0xc0(%rsp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm1
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm2
               	testb	$0x1, %al
               	jne	<addr>
               	leaq	0xe0(%rsp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0xe0(%rsp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vfmadd231ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x30(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	movups	-0x50(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0,0,0]
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	xorl	%eax, %eax
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movups	-0x30(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm1 # xmm1 = xmm14[1,0,0,0]
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm2 # xmm2 = xmm14[1,0,0,0]
               	movups	-0x50(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm3 # xmm3 = xmm14[1,0,0,0]
               	vfmadd213ss	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movups	-0x30(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm1 # xmm1 = xmm14[2,0,0,0]
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm2 # xmm2 = xmm14[2,0,0,0]
               	movups	-0x50(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm3 # xmm3 = xmm14[2,0,0,0]
               	vfmadd213ss	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movups	-0x30(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm1 # xmm1 = xmm14[3,0,0,0]
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm2 # xmm2 = xmm14[3,0,0,0]
               	movups	-0x50(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm3 # xmm3 = xmm14[3,0,0,0]
               	vfmadd213ss	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	leaq	0xc0(%rsp), %rdx
               	movups	%xmm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x30(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	movups	-0x50(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	xorl	%eax, %eax
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movups	-0x30(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm1 # xmm1 = xmm14[1,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm2 # xmm2 = xmm14[1,0,0,0]
               	movups	-0x50(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm3 # xmm3 = xmm14[1,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm3
               	vfmadd213ss	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movups	-0x30(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm1 # xmm1 = xmm14[2,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm2 # xmm2 = xmm14[2,0,0,0]
               	movups	-0x50(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm3 # xmm3 = xmm14[2,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm3
               	vfmadd213ss	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movups	-0x30(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm1 # xmm1 = xmm14[3,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm2 # xmm2 = xmm14[3,0,0,0]
               	movups	-0x50(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm3 # xmm3 = xmm14[3,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm3
               	vfmadd213ss	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	leaq	0xc0(%rsp), %rdx
               	movups	%xmm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x30(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	movups	-0x50(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0,0,0]
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovd	%xmm0, %r11d
               	movups	-0x30(%rbp), %xmm0
               	vpinsrd	$0x0, %r11d, %xmm0, %xmm0
               	leaq	0xc0(%rsp), %rdx
               	movups	%xmm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x30(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	movups	-0x40(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0,0,0]
               	movups	-0x50(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovd	%xmm0, %r11d
               	movups	-0x30(%rbp), %xmm0
               	vpinsrd	$0x0, %r11d, %xmm0, %xmm0
               	leaq	0xc0(%rsp), %rdx
               	movups	%xmm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x8(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x120(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movsd	0x120(%rsp), %xmm0
               	movsd	0xe0(%rsp), %xmm1
               	movsd	0xc0(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	0x128(%rsp), %xmm0
               	movsd	0xe8(%rsp), %xmm1
               	movsd	0xc8(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	0x130(%rsp), %xmm0
               	movsd	0xf0(%rsp), %xmm1
               	movsd	0xd0(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x138(%rsp), %xmm0
               	movsd	0xf8(%rsp), %xmm1
               	movsd	0xd8(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	movq	-0x10(%rbp), %rsi
               	movq	-0x8(%rbp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x120(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movsd	0x120(%rsp), %xmm0
               	movsd	0xe0(%rsp), %xmm1
               	movsd	0xc0(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	0x128(%rsp), %xmm0
               	movsd	0xe8(%rsp), %xmm1
               	movsd	0xc8(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	0x130(%rsp), %xmm0
               	movsd	0xf0(%rsp), %xmm1
               	movsd	0xd0(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x138(%rsp), %xmm0
               	movsd	0xf8(%rsp), %xmm1
               	movsd	0xd8(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	movq	-0x10(%rbp), %rsi
               	movq	-0x8(%rbp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x120(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movsd	0x120(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0xe0(%rsp), %xmm1
               	movsd	0xc0(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	0x128(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0xe8(%rsp), %xmm1
               	movsd	0xc8(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	0x130(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0xf0(%rsp), %xmm1
               	movsd	0xd0(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x138(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0xf8(%rsp), %xmm1
               	movsd	0xd8(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	movq	-0x10(%rbp), %rsi
               	movq	-0x8(%rbp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdx
               	leaq	0x120(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movsd	0x120(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0xe0(%rsp), %xmm1
               	movsd	0xc0(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	0x128(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0xe8(%rsp), %xmm1
               	movsd	0xc8(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	0x130(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0xf0(%rsp), %xmm1
               	movsd	0xd0(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x138(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0xf8(%rsp), %xmm1
               	movsd	0xd8(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	movq	-0x10(%rbp), %rsi
               	movq	-0x8(%rbp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x100(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x120(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	leaq	0xc0(%rsp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movsd	(%r8), %xmm1
               	leaq	(%rsi,%rcx), %r8
               	movsd	(%r8), %xmm2
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	cmpl	$0x1, %r8d
               	jne	<addr>
               	leaq	0xe0(%rsp), %r8
               	addq	%r8, %rcx
               	movsd	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0xe0(%rsp), %r8
               	addq	%r8, %rcx
               	movsd	(%rcx), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movsd	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x100(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x120(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	xorl	%eax, %eax
               	leaq	0xc0(%rsp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movsd	(%r8), %xmm1
               	leaq	(%rsi,%rcx), %r8
               	movsd	(%r8), %xmm2
               	testb	$0x1, %al
               	jne	<addr>
               	leaq	0xe0(%rsp), %r8
               	addq	%r8, %rcx
               	movsd	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0xe0(%rsp), %r8
               	addq	%r8, %rcx
               	movsd	(%rcx), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movsd	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rdi, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x60(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movups	-0x70(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	movups	-0x80(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0]
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	xorl	%eax, %eax
               	vmovq	%xmm0, %r11
               	vmovq	%r11, %xmm0
               	movups	-0x60(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm1 # xmm1 = xmm14[1,0]
               	movups	-0x70(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm2 # xmm2 = xmm14[1,0]
               	movups	-0x80(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm3 # xmm3 = xmm14[1,0]
               	vfmadd213sd	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	vmovq	%xmm1, %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	leaq	0xc0(%rsp), %rdx
               	movups	%xmm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x60(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movups	-0x70(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	movups	-0x80(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0]
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	xorl	%eax, %eax
               	vmovq	%xmm0, %r11
               	vmovq	%r11, %xmm0
               	movups	-0x60(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm1 # xmm1 = xmm14[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movups	-0x70(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm2 # xmm2 = xmm14[1,0]
               	movups	-0x80(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm3 # xmm3 = xmm14[1,0]
               	vfmadd213sd	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm1) + xmm3
               	vmovq	%xmm1, %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	leaq	0xc0(%rsp), %rdx
               	movups	%xmm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x60(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movups	-0x70(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	movups	-0x80(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0]
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovq	%xmm0, %r11
               	movups	-0x60(%rbp), %xmm0
               	vpinsrq	$0x0, %r11, %xmm0, %xmm0
               	leaq	0xc0(%rsp), %rdx
               	movups	%xmm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x60(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movups	-0x70(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm1 # xmm1 = xmm14[0,0]
               	movups	-0x80(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm2 # xmm2 = xmm14[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	vmovq	%xmm0, %r11
               	movups	-0x60(%rbp), %xmm0
               	vpinsrq	$0x0, %r11, %xmm0, %xmm0
               	leaq	0xc0(%rsp), %rdx
               	movups	%xmm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x8(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xc0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x3f800000, 0xc0(%rsp) # imm = 0x3F800000
               	movl	$0x40000000, 0xc4(%rsp) # imm = 0x40000000
               	movl	$0x40400000, 0xc8(%rsp) # imm = 0x40400000
               	movl	$0x40800000, 0xcc(%rsp) # imm = 0x40800000
               	movl	$0x40a00000, 0xd0(%rsp) # imm = 0x40A00000
               	movl	$0x40c00000, 0xd4(%rsp) # imm = 0x40C00000
               	movl	$0x40e00000, 0xd8(%rsp) # imm = 0x40E00000
               	movl	$0x41000000, 0xdc(%rsp) # imm = 0x41000000
               	leaq	0xc0(%rsp), %rax
               	leaq	0xe0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rsi # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rdi # imm = 0x4010000000000000
               	leaq	0xc0(%rsp), %rdx
               	movq	%rdi, %xmm14
               	movsd	%xmm14, 0xc0(%rsp)
               	movq	%rsi, %xmm14
               	movsd	%xmm14, 0xc8(%rsp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0xd0(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0xc0(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0xc8(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0xd0(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0xd8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x30(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm0
               	movups	-0x40(%rbp), %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	leaq	0xc0(%rsp), %rdx
               	vmovups	%ymm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movups	-0x60(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm0
               	movups	-0x70(%rbp), %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm0
               	leaq	0xc0(%rsp), %rdx
               	vmovups	%ymm0, 0xc0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	vzeroupper
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x140, %rsp            # imm = 0x140
               	andq	$-0x20, %rsp
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%r12,4), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ebx, %ebx
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xc0(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa0(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xbc(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x9c(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb8(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x98(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb4(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x94(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb0(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x90(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xac(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x8c(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa8(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x88(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa4(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x84(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x60(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x40(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x58(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x38(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x50(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x30(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x48(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x28(%rbp)
               	leaq	(%rsp), %r9
               	leaq	-0xc0(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x20(%rsp), %rax
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdx
               	leaq	-0x40(%rbp), %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	subq	$0x80, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x60(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x68(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	callq	<addr>
               	addq	$0x80, %rsp
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xc0(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa0(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x80(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xbc(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x9c(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x7c(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb8(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x98(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x78(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb4(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x94(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x74(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb0(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x90(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x70(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xac(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x8c(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x6c(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa8(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x88(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x68(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa4(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x84(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x64(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x60(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x40(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x58(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x38(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x18(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x50(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x30(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x48(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x28(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	0x80(%rsp), %r9
               	leaq	-0xc0(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0xa0(%rsp), %rax
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xc0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xe0(%rsp), %rdx
               	leaq	-0x60(%rbp), %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x100(%rsp), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x100(%rsp), %rsi
               	leaq	0x120(%rsp), %rdi
               	leaq	-0x20(%rbp), %r8
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x120(%rsp), %rdi
               	subq	$0xc0, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x60(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x68(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%rsi, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x80(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x88(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x90(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x98(%rsp)
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xa0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xa8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0xb0(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0xb8(%rsp)
               	callq	<addr>
               	addq	$0xc0, %rsp
               	incq	%rbx
               	cmpl	$0x96, %ebx
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x2df3754bb839cc40, %r11 # imm = 0xD20C8AB447C633C0
               	cmpq	%r11, %rcx
               	je	<addr>
               	incq	%rax
               	leaq	-0xd0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x74ccbd3f6dc406f9, %r11 # imm = 0x74CCBD3F6DC406F9
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x1109575788509c5, %r11 # imm = 0x1109575788509C5
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x22e32b377fe2c5f9, %r11 # imm = 0x22E32B377FE2C5F9
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x643ff85c67bfe70e, %r11 # imm = 0x643FF85C67BFE70E
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x1399ba70a23f6f3f, %r11 # imm = 0x1399BA70A23F6F3F
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x59fced26f1c647c3, %r11 # imm = 0xA60312D90E39B83D
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x65ee5915fc0be271, %r11 # imm = 0x9A11A6EA03F41D8F
               	cmpq	%r11, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0xd0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
